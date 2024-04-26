import 'package:flutter/material.dart';

import '../../Services/Network/http_service.dart';

class Authors extends StatefulWidget {
  const Authors({Key? key}) : super(key: key);

  @override
  State<Authors> createState() => _AuthorsState();
}

class _AuthorsState extends State<Authors> {

  List data=[];
  bool loading = false;

  String url='api/authors-with-book-count';

  Future<void> getData() async {
    try {
      setState(() {
        loading = true;
      });

      HttpService httpService = HttpService();
      var response = await httpService.get('$url');

      if (response.statusCode == 200) {
        // print('data=${response.data}');
        data = response.data;
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
  }

  @override
  Widget build(BuildContext context) {
    // print('data.length=${data.length}');
    return Scaffold(
      body: loading?
      const Center(child: CircularProgressIndicator())
          :ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: (){
            },
            title: Text(data[index]['author']),
            subtitle: Text('أجمالي الكتب : ${data[index]['book_count'].toString()}'),
            leading: const Icon(Icons.supervised_user_circle_sharp),
            trailing: Image.asset('assets/images/user-min.png'),
          );
        },
      ),
    );
  }
}
