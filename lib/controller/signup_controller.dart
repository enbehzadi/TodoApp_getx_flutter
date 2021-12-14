import 'package:flutter/material.dart';
import 'package:flutter_app_todo/screen/login_screen.dart';
import 'package:flutter_app_todo/screen/task_screen.dart';
import 'package:get/get.dart';
import '../constants.dart';
import 'dart:convert' as convert;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class SignupController extends GetxController {
  late TextEditingController name_contoroller,email_contoroller,
      password_contoroller,age_contoroller,repeat_password_contoroller;

  @override
  void onInit() {
    // TODO: implement onInit
    name_contoroller=TextEditingController();
    email_contoroller=TextEditingController();
    password_contoroller=TextEditingController();
    repeat_password_contoroller=TextEditingController();
    age_contoroller=TextEditingController();
    super.onInit();
  }
   signup(name,email,password,age)async{
     print('${email}');
      Map <String,String>header={
        "Content-Type":"application/json",
      };
      Map <String,String>body={
        "name": name,
        "email": email,
        "password": password,
        "age": age
      };
      var url ="https://api-nodejs-todolist.herokuapp.com/user/register";
      // Await the http get response, then decode the json-formatted response.
      var response = await http.post(Uri.parse(url),body: convert.jsonEncode(body),headers:header);
      if (response.statusCode == 201) {
        var jsonResponse = convert.jsonDecode(response.body) ;
        print (jsonResponse);
        Get.snackbar("Success!", "Registered Successfully",backgroundColor:Colors.green);


          final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
          final SharedPreferences prefs=await _prefs;
          prefs.setString("user_token", jsonResponse['token']);
          Get.offAndToNamed("/task_screen");

      } else {
        Get.snackbar("Error", "Not Registered!!",backgroundColor:Colors.red);
        print('Request failed with status: ${response.statusCode}.');

      }
  }


}
