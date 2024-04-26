import 'package:bookstore/Controller/OrderProvider.dart';
import 'package:bookstore/Model/Book.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../Services/Network/http_service.dart';

class Books extends StatefulWidget {
  const Books({Key? key}) : super(key: key);

  @override
  State<Books> createState() => _BooksState();
}

class _BooksState extends State<Books> {

  List<Book> data=[];
  bool loading = false;

  String url='api/books';

  bool hasMoreData = true; // Initialize a flag to track if there are more pages to fetch

  Future<void> getData() async {
    if (loading || !hasMoreData) return; // Check if loading or no more data available
    try {
      setState(() {
        loading = true;
      });

      HttpService httpService = HttpService();
      var response = await httpService.get('$url?page=$_page');

      if (response.statusCode == 200) {
        // print('data=${response.data}');
        var jsonData = response.data as Map<String, dynamic>;
        List<Book> newBooks = [];
        if (jsonData['data'] != null && (jsonData['data'] as List).isNotEmpty) {
          newBooks = (jsonData['data'] as List).map((item) => Book.fromJson(item)).toList();
          setState(() {
            data.addAll(newBooks);
            _page++;
            loading = false;
          });
        } else {
          print('No more data available.');
          hasMoreData = false; // Set flag to false when no more data is available
        }
      } else {
        print('error=${response.data}');
      }
    } catch (e) {
      print('e=$e');
    } finally {
      setState(() {
        loading = false;
      });
    }
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    _scrollController.addListener(_scrollListener);
  }

  int _page = 1;
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      getData();
    }
  }

  @override
  Widget build(BuildContext context) {
    // print('data.length=${data.length}');
    var orderService = Provider.of<OrderProvider>(context, listen: true);
    return RefreshIndicator(
      onRefresh: () async {
        getData();
      },
      child: Scaffold(
        body: loading?
        const Center(child: CircularProgressIndicator())
            :ListView.builder(
          controller: _scrollController,
          itemCount: data.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                  onTap: (){
                    Get.toNamed('/BooksDetials', arguments: data[index]);
                  },
                  title: Text(data[index].title),
                  subtitle: Text(data[index].author),
                  leading: const Icon(Icons.book),
                  trailing: Image.asset('assets/playstore.png'),
                ),
            );
          },
        ),

        floatingActionButton:   FloatingActionButton(
      onPressed: () {
        // افتح شاشة عرض الطلبات هنا
        Get.toNamed('/order');
      },
      child: Stack(
        fit:StackFit.expand,
        children: [
          const Icon(Icons.shopping_cart),
          Positioned(
            right: 5,
            top: 5,
            child: CircleAvatar(
              radius: 10,
              backgroundColor: Colors.red, // لون الدائرة
              child: Text(
                '${orderService.orders.length}',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white, // لون النص
                ),
              ),
            ),
          ),
        ],
      ),),

      ),
    );
  }
}
