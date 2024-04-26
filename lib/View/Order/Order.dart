import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Controller/OrderProvider.dart';
import '../../Services/Constant/constant.dart';

class Order extends StatelessWidget {
  const Order({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var orderService = Provider.of<OrderProvider>(context, listen: true);
    // print('orderService=${orderService.orders}');
    return Scaffold(
      appBar: AppBar(
        title: const Text('قائمة الطلبات'),
        actions: [
          TextButton.icon(
            icon: const Icon(Icons.close),
            label: const Text('حذف الكل'),
            onPressed: () {
              orderService.removeAllOrders();
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: orderService.orders.length,
        itemBuilder: (context, index) {
          final order = orderService.orders[index];
          return ListTile(
            onTap: (){},
            title: Text(order['title']),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('المؤلف: ${order['author']}'),
                Text('النوع: ${order['genre']}'),
                Text('الكمية: ${order['quantity']}'),
                Text('السعر: ${order['price'].toStringAsFixed(2)} \$'),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                orderService.removeOrderAtIndex(index);
              },
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
          !loginState || type!='user'?
              const Text('يرجى تسجيل الدخول لارسال الطلب')
              :
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('الإجمالي: ${orderService.total.toStringAsFixed(2)} \$'),
              ElevatedButton(
                onPressed: () {
                  orderService.saveOrder(context);
                },
                child: const Text('تأكيد وإرسال الطلب'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
