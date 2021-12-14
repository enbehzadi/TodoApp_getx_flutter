import 'package:flutter/material.dart';
import 'package:flutter_app_todo/screen/signup_screen.dart';
import 'package:flutter_app_todo/screen/task_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'Internationalization/messages.dart';
import 'screen/login_screen.dart';
import 'screen/splash_screen.dart';
void main() async{
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return
      GetMaterialApp(

      debugShowCheckedModeBanner: false,
      translations: Messages(),// your translations
      locale: Get.deviceLocale,
      fallbackLocale: Locale('en', 'US'),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => SplashScreen(),
            transition: Transition.zoom,
            transitionDuration: Duration(seconds: 1)),
        GetPage(name: '/login_screen', page: () =>
           LoginScreen(),transition: Transition.rightToLeft,
            transitionDuration: Duration(seconds: 1)),
        GetPage(name: '/task_screen', page: () => TaskScreen(),
            transition: Transition.rightToLeft,transitionDuration: Duration(seconds: 1)),
        GetPage(name: '/signup_screen', page: () => SignupScreen(),transition: Transition.rightToLeft,transitionDuration: Duration(seconds: 1)),
      ],
           home:SplashScreen(),
         );



  }
}

