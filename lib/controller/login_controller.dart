import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
class LoginController extends GetxController {
  late TextEditingController email_contoroller,password_contoroller;
  @override
  void onInit() {
    // TODO: implement onInit
    email_contoroller=TextEditingController();
    password_contoroller=TextEditingController();
    super.onInit();
}
   login(email,password)async{
      Map <String,String>header={
        "Content-Type":"application/json",
      };
      Map <String,String>body={
        "email":email,
        "password":password,
      };
      var url ="https://api-nodejs-todolist.herokuapp.com/user/login";
      // Await the http get response, then decode the json-formatted response.
      var response = await http.post(Uri.parse(url),body: convert.jsonEncode(body),headers:header);
      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body) ;
        final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
        final SharedPreferences prefs=await _prefs;
        prefs.setString("user_token", jsonResponse['token']);
        Get.offAndToNamed("/task_screen");

      } else {
        Get.snackbar("Error", "input information carefully!!".tr,backgroundColor:Colors.red);
      }
  }


}
