import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../Model/Book.dart';
import '../Services/Constant/constant.dart';
import '../Services/Network/http_service.dart';

class OrderProvider extends ChangeNotifier {
  double total = 0;
  List<Map<String, dynamic>> orders = [];
  bool isloadingSave = true;
  bool isError = false;
  String url = '';

  Future<void> calculateTotal() async {
    double calculatedTotal = 0;
    for (var order in orders) {
      calculatedTotal += order['price'] * order['quantity'];
    }
    total = calculatedTotal;
    notifyListeners();
  }

  Future<void> addOrder(Book book) async {
    try {
      int existingOrderIndex = orders.indexWhere((order) => order['bookId'] == book.bookId);
      if (existingOrderIndex != -1) {
        orders[existingOrderIndex]['quantity']++;
      } else {
        Map<String, dynamic> order = {
          'bookId': book.bookId,
          'title': book.title,
          'price': book.price,
          'author': book.author,
          'genre': book.genre,
          'availability': book.availability,
          'quantity': 1,
        };
        orders.add(order);
      }
      await _saveOrders();
      await calculateTotal();
    } catch (e) {
      print('e=$e');
    }
  }

  Future<void> removeOrder(Book book) async {
    int existingOrderIndex = orders.indexWhere((order) => order['bookId'] == book.bookId);
    if (existingOrderIndex != -1) {
      if (orders[existingOrderIndex]['quantity'] > 1) {
        orders[existingOrderIndex]['quantity']--;
      } else {
        orders.removeAt(existingOrderIndex);
      }
      await _saveOrders();
      await calculateTotal();
    }
  }

  Future<void> removeOrderAtIndex(int index) async {
    if (index >= 0 && index < orders.length) {
      if (orders[index]['quantity'] > 1) {
        orders[index]['quantity']--;
      } else {
        orders.removeAt(index);
      }
      await _saveOrders();
      await calculateTotal();
    }
  }

  Future<void> removeAllOrders() async {
    orders.clear();
    total = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('orders');
    notifyListeners();
  }

  int orderQuantity(Book book) {
    Map<String, dynamic>? order = orders.firstWhere((order) => order['bookId'] == book.bookId, orElse: () => {});
    return order != null ? (order['quantity'] ?? 0) : 0;
  }

  Future<void> saveOrder(BuildContext context) async {
    isloadingSave = true;
    url = 'api/order';

    Map<String, dynamic> orderData = {
      'user_id': newId, // Replace with the actual user ID
      'orderType': 'delivery',
      'items': orders,
      'location': 'your_location_here',
      'payment': 'cash',
      'customerNotes': 'any_notes_here',
      'total': total,
      'state': 0,
    };

    try {
      HttpService httpService = HttpService();
      Response response = await httpService.post(url, orderData);

      print('response.statusCode=${response.statusCode}');
      print('response.data=${response.data}');
      if(response.statusCode==201 || response.statusCode==200){
        isloadingSave = false;
        await removeAllOrders();
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('تم الارسال بنجاح!'),
              ));
      }

    } catch (error) {
      isError = true;
      print('Error fetching data: $error');
    }
    notifyListeners();
  }

  Future<void> _saveOrders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('orders', json.encode(orders));
  }

  Future<void> _loadOrders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? ordersString = prefs.getString('orders');
    if (ordersString != null && ordersString.isNotEmpty) {
      orders = List<Map<String, dynamic>>.from(json.decode(ordersString));
    }
    await calculateTotal();
  }

  OrderProvider() {
    _loadOrders();
  }
}
