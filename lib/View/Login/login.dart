import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../Services/Constant/constant.dart';
import '../../Services/Network/http_service.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State {

  TextEditingController loginEmail =TextEditingController();
  TextEditingController loginPassword =TextEditingController();

  bool _loading = false;

  String url='api/login';

  Future<void> _submitLogin() async {

    try{
      setState(() {
        _loading = true;
      });

      HttpService httpService= HttpService();
      var response=await httpService.post(url,{
        'email': loginEmail.text.trim(),
        'password': loginPassword.text.trim(),
      });

      if(response.statusCode==200){
        // print('data=${response.data}');

        // استخراج البيانات وتخزينها في الذاكرة المحلية
        var userData = response.data['user'];
        newId = userData['id'].toString();
         name = userData['name'].toString();
         type = userData['type'].toString();
         email = userData['email'].toString();
         createdAt = userData['created_at'].toString();
         accessToken = response.data['access_token'].toString();
         loginState=true;
         // ---------
        // تخزين بيانات تسجيل الدخول باستخدام FlutterSecureStorage
        const storage = FlutterSecureStorage();
        await storage.write(key: 'loginState', value: loginState.toString());
        await storage.write(key: 'newId', value: newId.toString());
        await storage.write(key: 'access_token', value: accessToken.toString());

        await storage.write(key: 'name', value: name.toString());
        await storage.write(key: 'type', value: type.toString());
        await storage.write(key: 'email', value: email.toString());
        await storage.write(key: 'createdAt', value: createdAt.toString());

      }else{
        print('error=${response.data}');
      }

    }catch(e){
      print('e=$e');
    }finally{
      setState(() {
        _loading = false;
      });
    }
  }

  Future<void> logOut() async {
    newId = null;
    name = null;
    type = null;
    email = null;
    createdAt = null;
    accessToken = null;
    loginState=false;
    setState(() {});
    // ---------
    // تخزين بيانات تسجيل الدخول باستخدام FlutterSecureStorage
    const storage = FlutterSecureStorage();
    await storage.deleteAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: loginState?
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/user-min.png',color: Colors.transparent.withOpacity(0.7),),
                  Text(name.toString(),style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),const Divider(),
                  Text('نوع الحساب : ${type.toString()}'),
                  Text(email.toString()),
                  // Text(accessToken.toString()),
                  // Text(createdAt.toString()),
                  const SizedBox(height: 10,),
                  ElevatedButton(onPressed: logOut, child: const Text('تسجيل الخروج')),
                ],
              )
              :Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: [
                  Image.asset('assets/images/user-min.png',color: Colors.transparent.withOpacity(0.7),),
                  const Text('تسجيل الدخول'),
                  TextField(
                    controller: loginEmail,
                    decoration: const InputDecoration(
                      labelText: 'البريد الإلكتروني',
                    ),
                  ),
                  TextField(
                    controller: loginPassword,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'كلمة المرور',
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _submitLogin,
                    child: const Text('تسجيل الدخول'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}




// ------------



// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import '../../Services/Constant/constant.dart';
// import '../../Services/Network/http_service.dart';
//
// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State {
//
//   TextEditingController loginEmail =TextEditingController();
//   TextEditingController loginPassword =TextEditingController();
//
//   TextEditingController signupName =TextEditingController();
//   TextEditingController signupEmail =TextEditingController();
//   TextEditingController signupPassword =TextEditingController();
//
//   bool _showLoginForm = true;
//   bool _loading = false;
//
//   String url='api/login';
//
//   Future<void> _submitLogin() async {
//
//     try{
//       setState(() {
//         _loading = true;
//       });
//
//       HttpService httpService= HttpService();
//       var response=await httpService.post(url,{
//         'email': loginEmail.text.trim(),
//         'password': loginPassword.text.trim(),
//       });
//
//       if(response.statusCode==200){
//         // print('data=${response.data}');
//
//         // استخراج البيانات وتخزينها في الذاكرة المحلية
//         var userData = response.data['user'];
//         newId = userData['id'].toString();
//         name = userData['name'].toString();
//         type = userData['type'].toString();
//         email = userData['email'].toString();
//         createdAt = userData['created_at'].toString();
//         accessToken = response.data['access_token'].toString();
//         loginState=true;
//         // ---------
//         // تخزين بيانات تسجيل الدخول باستخدام FlutterSecureStorage
//         const storage = FlutterSecureStorage();
//         await storage.write(key: 'loginState', value: loginState.toString());
//         await storage.write(key: 'newId', value: newId.toString());
//         await storage.write(key: 'access_token', value: accessToken.toString());
//
//         await storage.write(key: 'name', value: name.toString());
//         await storage.write(key: 'type', value: type.toString());
//         await storage.write(key: 'email', value: email.toString());
//         await storage.write(key: 'createdAt', value: createdAt.toString());
//
//       }else{
//         print('error=${response.data}');
//       }
//
//     }catch(e){
//       print('e=$e');
//     }finally{
//       setState(() {
//         _loading = false;
//       });
//     }
//   }
//
//   Future<void> logOut() async {
//     newId = null;
//     name = null;
//     type = null;
//     email = null;
//     createdAt = null;
//     accessToken = null;
//     loginState=false;
//     setState(() {});
//     // ---------
//     // تخزين بيانات تسجيل الدخول باستخدام FlutterSecureStorage
//     const storage = FlutterSecureStorage();
//     await storage.deleteAll();
//   }
//
//
//   Future<void> _submitSignup() async {
//     setState(() {
//       _loading = true;
//     });
// // إرسال طلب الإنشاء هنا
//
//     HttpService httpService= HttpService();
//     httpService.post(url,{});
//
// // بعد استلام الرد
//     setState(() {
//       _loading = false;
//       // if (response.success) {
//       //   _snackbarText = 'تم إنشاء الحساب بنجاح';
//       // } else {
//       //   _snackbarText = 'فشل إنشاء الحساب';
//       // }
//
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _loading
//           ? const Center(
//         child: CircularProgressIndicator(),
//       )
//           : SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: loginState?
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.asset('assets/images/user-min.png',color: Colors.transparent.withOpacity(0.7),),
//               Text(name.toString(),style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),const Divider(),
//               Text('نوع الحساب : ${type.toString()}'),
//               Text(email.toString()),
//               // Text(accessToken.toString()),
//               // Text(createdAt.toString()),
//               const SizedBox(height: 10,),
//               ElevatedButton(onPressed: logOut, child: const Text('تسجيل الخروج')),
//             ],
//           )
//               :Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               _showLoginForm
//                   ? Column(
//                 children: [
//                   const Text('تسجيل الدخول'),
//                   TextField(
//                     controller: loginEmail,
//                     decoration: const InputDecoration(
//                       labelText: 'البريد الإلكتروني',
//                     ),
//                   ),
//                   TextField(
//                     controller: loginPassword,
//                     obscureText: true,
//                     decoration: const InputDecoration(
//                       labelText: 'كلمة المرور',
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: _submitLogin,
//                     child: const Text('تسجيل الدخول'),
//                   ),
//                 ],
//               )
//                   : Column(
//                 children: [
//                   const Text('إنشاء حساب جديد'),
//                   TextField(
//                     controller: signupName,
//                     decoration: const InputDecoration(
//                       labelText: 'الاسم',
//                     ),
//                   ),
//                   TextField(
//                     controller: signupEmail,
//                     decoration: const InputDecoration(
//                       labelText: 'البريد الإلكتروني',
//                     ),
//                   ),
//                   TextField(
//                     controller: signupPassword,
//                     obscureText: true,
//                     decoration: const InputDecoration(
//                       labelText: 'كلمة المرور',
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: _submitSignup,
//                     child: const Text('إنشاء الحساب'),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               const Divider(),
//               const SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   TextButton(
//                     onPressed: () {
//                       setState(() {
//                         _showLoginForm = true;
//                       });
//                     },
//                     child: const Text('تسجيل الدخول'),
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       setState(() {
//                         _showLoginForm = false;
//                       });
//                     },
//                     child: const Text('إنشاء حساب جديد'),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }