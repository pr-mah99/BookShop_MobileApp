import 'package:bookstore/Controller/OrderProvider.dart';
import 'package:bookstore/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'MainMenu.dart';
import 'Services/Constant/constant.dart';
import 'Services/UI/theme.dart';
import 'View/Books/BooksDetials.dart';
import 'View/Order/Order.dart';
import 'View/Setting/Setting.dart';
import 'View/errorPage.dart';
import 'Widget/MyCustomScrollBehavior.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const storage = FlutterSecureStorage();
  var t=await storage.read(key: 'loginState');
  loginState =  (t.toString()=="true")? true:false;
  newId=await storage.read(key: 'newId');
  accessToken=await storage.read(key: 'access_token');

  name=await storage.read(key: 'name');
  type=await storage.read(key: 'type');
  email=await storage.read(key: 'email');
  createdAt=await storage.read(key: 'createdAt');
  // ------
  SharedPreferences prefs = await SharedPreferences.getInstance();
  ipAddress = prefs.getString("IP_Address") ?? '127.0.0.1:8000';

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<OrderProvider>(create: (_) => OrderProvider()),
  ],
  child: MyApp()));
}

class MyApp extends StatefulWidget {
   MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final RxBool _isLightTheme = false.obs;

  _getThemeStatus() async {
    var isLight = _prefs.then((SharedPreferences prefs) {
      return prefs.getBool('theme') ?? false;
    }).obs;
    _isLightTheme.value = (await isLight.value);
    Get.changeThemeMode(_isLightTheme.value ? ThemeMode.light : ThemeMode.dark);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getThemeStatus();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BookStore',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
        fontFamily: 'Droid Arabic Kufi',
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: buttonStyleLight,
        ),
        textButtonTheme: TextButtonThemeData(
          style: buttonStyleLight,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
        fontFamily: 'Droid Arabic Kufi',
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: buttonStyleDark,
        ),
        textButtonTheme: TextButtonThemeData(
          style: buttonStyleDark,
        ),
      ),

      // Scroll  - سحب
      scrollBehavior: MyCustomScrollBehavior(),
      // Scroll  - السحب انتهى


      themeMode: _isLightTheme.value ? ThemeMode.light:ThemeMode.dark,

      // home: MyHomePage(),
      initialRoute: '/splash',
      // initialRoute: '/',
      unknownRoute: GetPage(
          name: '/notfound',
          page: () => const errorPage()), //like 404 page in web
      getPages: [
        GetPage(name: '/splash', page: () => const splashScreen()),
        GetPage(name: '/', page: () => MainMenu(),
            transition: Transition.cupertino),
        GetPage(
            name: '/BooksDetials',
            page: () => BooksDetials(),
            transition: Transition.cupertino),
        GetPage(
            name: '/setting',
            page: () => settingScreen(),
            transition: Transition.cupertino),
        GetPage(
            name: '/order',
            page: () => const Order(),
            transition: Transition.zoom),
        // GetPage(
        //     name: '/top',
        //     page: () =>  UserScreen(),
        //     transition: Transition.zoom),
        // GetPage(
        //     name: '/topDetails',
        //     page: () =>  const UserDetailsScreen(),
        //     transition: Transition.circularReveal),
        // GetPage(
        //     name: '/result',
        //     page: () => const resultScreen(),
        //     transition: Transition.zoom),
      ],
    );
  }
}
