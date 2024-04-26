import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Services/Constant/constant.dart';

class settingScreen extends StatefulWidget {
  settingScreen({super.key});

  @override
  State<settingScreen> createState() => _settingScreenState();
}

class _settingScreenState extends State<settingScreen> {

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final RxBool _isLightTheme = false.obs;

  _saveThemeStatus() async {
    SharedPreferences pref = await _prefs;
    pref.setBool('theme', _isLightTheme.value);
  }

  _getThemeStatus() async {
    var isLight = _prefs.then((SharedPreferences prefs) {
      return prefs.getBool('theme') ?? false;
    }).obs;
    _isLightTheme.value = (await isLight.value);
    Get.changeThemeMode(_isLightTheme.value ? ThemeMode.light : ThemeMode.dark);
  }

  // ---------------


  final ipAddressValue = TextEditingController();

  Future<void> Setting_ip(String ip) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      'IP_Address',
      ip,
    );
    serverName = "http://$ip/";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getThemeStatus();
    ipAddressValue.text=ipAddress;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ألاعدادات'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20,),

            TextFormField(
              controller: ipAddressValue,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: "IP Address",
                prefixIcon: Icon(
                  Icons.phone_iphone,
                ),
              ),
              onChanged: (String val) {
                setState(() {
                  ipAddress = val.trim();
                });
                Setting_ip(val.trim());
              },
            ),

            const SizedBox(height: 20,),
            const Text(
              'تبديل بين الليل والنهار',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ObxValue(
                  (data) => Switch(
                value: _isLightTheme.value,
                onChanged: (val) {
                  _isLightTheme.value = val;
                  Get.changeThemeMode(
                    _isLightTheme.value ? ThemeMode.light : ThemeMode.dark,
                  );
                  _saveThemeStatus();
                },
              ),
              false.obs,
            ),

            const SizedBox(
              height: 20,
            ),
            const Text(
              '@ 2024',
            ),
            const Text(
              'V 1.0.0',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),),
    );
  }
}