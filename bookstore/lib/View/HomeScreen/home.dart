import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              color: Colors.blue,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'اكتشف عالم الكتب',
                    style: TextStyle(
                      fontSize: 44.0,
                      color: Colors.white
                    ),
                  ),
                  Text(
                    'مع متجر الكتب الرقمي',
                    style: TextStyle(
                      fontSize: 34.0,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10.0),
            Image.asset('assets/images/books.jpg'),
            const SizedBox(height: 10.0),
            const Text(
              'أهلا بك في تطبيقنا الرسمي',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                // تنفيذ الإجراء عند الضغط على الزر
              },
              child: const Text('تواصل معنا'),
            ),
            const SizedBox(height: 10.0),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
