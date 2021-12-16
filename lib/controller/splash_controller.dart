import 'package:TodoApp2/screen/login_screen.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'database_controller.dart';
class SplashController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    _handelScreen();
    setTranslate();
    setTheme();
    super.onInit();
  }

  void _handelScreen()async{
    await Future.delayed(const Duration(milliseconds: 1200));
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs=await _prefs;
    if(prefs.getString("user_token")==null)
    {
      Get.off(()=>LoginScreen(),
          transition: Transition.zoom,
          duration: const Duration(microseconds: 800)
      );
    }
    else{
      check_user_token(prefs.getString("user_token").toString());
    }
  }
  setTheme()async{
    DatabaseController dbs=Get.put(DatabaseController());
    if(dbs.restoreStateDark())
    {
        Get.changeTheme(ThemeData.dark());
    }
    else
    {
        Get.changeTheme(ThemeData.light());
    }

  }

  setTranslate()async{
    DatabaseController dbs=Get.put(DatabaseController());
    if(dbs.restoreStateTranslate())
    {
      Get.updateLocale(Locale('fa','IR'));
    }
    else
    {
      Get.updateLocale(Locale('en','Us'));
    }

  }
   check_user_token(String userToken)async{

      Map <String,String>header={
        "Content-Type":"application/json",
        "Authorization":"Bearer $userToken",
      };

      var url ="https://api-nodejs-todolist.herokuapp.com/user/me";
      // Await the http get response, then decode the json-formatted response.
      var response = await http.get(Uri.parse(url),headers:header);
      if (response.statusCode == 200) {
        Get.offAndToNamed("/task_screen");
      } else {
        Get.offAndToNamed("/login_screen");
      }
  }
}
