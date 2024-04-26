import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../Controller/OrderProvider.dart';
import '../../Model/Book.dart';

class BooksDetials extends StatelessWidget {
  BooksDetials({Key? key}) : super(key: key);
  // final LectureController lectureController = Get.put(LectureController());
  final Book book= Get.arguments as Book;
  @override
  Widget build(BuildContext context) {
    print('data=$book');
    var orderService = Provider.of<OrderProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text("تفاصيل الكتاب"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment:MainAxisAlignment.center,
            children: [
              SizedBox(height: 10,),
              Image.asset('assets/playstore.png',width: 150,),
              SizedBox(height: 10,),
              Text('عنوان الكتاب : ${book.title}'),
              Text('أسم الكتاب : ${book.genre}'),
              Text('السعر : ${book.price}\$',textDirection: TextDirection.rtl,),
              Text('المؤلف : ${book.author}'),
              Text('رقم الكتاب : ${book.bookId}'),
              Text('تاريخ الاضافة : ${book.createdAt}'),
              Text('الحالة : ${book.availability==1?'متوفرة':'غير متوفرة'}'),


              SizedBox(height: 49,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  children: [
                    // زر النقصان
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        orderService.removeOrder(book);
                      },
                    ),
                    // عرض الكمية
                    Text(
                      orderService.orderQuantity(book).toString(),
                    ),
                    // زر الزيادة
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        orderService.addOrder(book);
                      },
                    ),
                    // عرض السعر الإجمالي
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'الاجمالي = ${(orderService.orderQuantity(book) * book.price).toStringAsFixed(2)} \$',
                          style: TextStyle(fontSize: 16),
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                    ),
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
