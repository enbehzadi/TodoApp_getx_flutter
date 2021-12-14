// ignore_for_file: avoid_single_cascade_in_expression_statements
import 'package:TodoApp/model/task_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'database_controller.dart';
class TaskController extends GetxController {
  RxBool loading=true.obs;
  RxList <task_model> tasks=<task_model>[].obs;
  RxBool idDark=false.obs;
  bool idLocale=false;

  @override
  void onInit() {
    getAllTask();
    setIddark();
    setLocale();
  }

  // ThemeData get theme => isDark ? ThemeData.dark() : ThemeData.light();
  void changeTheme(bool value) {

    idDark.value=value;
    if(value)
    {
      Get.changeTheme(ThemeData.dark());
    }
    else{
      Get.changeTheme(ThemeData.light());
    }
  }
  void setIddark() {
    if(Get.isDarkMode )
    {
      idDark.value=true;
    }
  }
  getAllTask() async {
    tasks.clear();
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs=await _prefs;
    var userToken=prefs.getString("user_token").toString();
    Map <String,String>header={
      "Content-Type":"application/json",
      "Authorization":"Bearer $userToken",
    };

    var url ="https://api-nodejs-todolist.herokuapp.com/task";
    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(Uri.parse(url),headers:header);
    if (response.statusCode == 200) {
      var jsonResponse =convert.jsonDecode(response.body) ;
      jsonResponse['data'].forEach((element)
      {
        tasks.add(task_model.fromJson(element));
      }
      );

    }
    else {
      print('Request failed with status: ${response.statusCode}.');
    }
    loading.value=false;
  }

  addTask(String description)async{
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs=await _prefs;
    var userToken=prefs.getString("user_token").toString();
    Map <String,String>header={
      "Content-Type":"application/json",
      "Authorization":"Bearer $userToken",
    };
    Map <String,String>body={
      "description":description,
    };
    print(userToken);

    var url ="https://api-nodejs-todolist.herokuapp.com/task";
    // Await the http get response, then decode the json-formatted response.
    var response = await http.post(Uri.parse(url),body: convert.jsonEncode(body),headers:header);
    if (response.statusCode == 201) {
      var jsonResponse = convert.jsonDecode(response.body) ;
        this.tasks.add(task_model.fromJson(jsonResponse['data']));
        Get.back();
        print(jsonResponse);
    } else {
      Get.snackbar("Error", "input information carefully!!",backgroundColor:Colors.red);
    }
  }
  updateTask(task_model task) async{
    var index=tasks.indexOf(task);
    task..completed=! task.completed;
    tasks[index]=task;
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs=await _prefs;
    var userToken=prefs.getString("user_token").toString();

    Map <String,String>header={
      "Content-Type":"application/json",
      "Authorization":"Bearer $userToken",
    };
    Map <String,String>body={
      "completed":"${task.completed}",
    };
    var url ="https://api-nodejs-todolist.herokuapp.com/task/${task.sId}";
    // Await the http get response, then decode the json-formatted response.
    var response = await http.put(Uri.parse(url),body: convert.jsonEncode(body),headers:header);
    if (response.statusCode == 200)
    {
      var jsonResponse =
      convert.jsonDecode(response.body) ;
      print('****** ${jsonResponse}');
    } else {
      task..completed=!task.completed;
      tasks[index]=task;
      Get.snackbar("Error", "Dont Update Task!!",backgroundColor:Colors.red);
    }

  }
  deleteTask(task_model task)async{
    var index=tasks.indexOf(task);
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs=await _prefs;
    var userToken=prefs.getString("user_token").toString();
    Map <String,String>header={
      "Content-Type":"application/json",
      "Authorization":"Bearer $userToken",
    };
    var url ="https://api-nodejs-todolist.herokuapp.com/task/${task.sId}";
    // Await the http get response, then decode the json-formatted response.
    var response = await http.delete(Uri.parse(url),headers:header);
    if (response.statusCode == 200)
    {
      var jsonResponse =
      convert.jsonDecode(response.body) ;
      print('****** ${jsonResponse}');
      tasks.removeAt(index);
    } else {
      Get.snackbar("Error", "Dont Delete Task!!",backgroundColor:Colors.red);
    }
  }
  logout()async{
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs=await _prefs;
    var userToken=prefs.getString("user_token").toString();
    Map <String,String>header={
      "Content-Type":"application/json",
      "Authorization":"Bearer $userToken",
    };
    var url ="https://api-nodejs-todolist.herokuapp.com/user/logout";
    // Await the http get response, then decode the json-formatted response.
    var response = await http.post(Uri.parse(url),headers:header);
    if (response.statusCode == 200)
    {
      var jsonResponse =
      convert.jsonDecode(response.body) ;
      print('****** ${jsonResponse}');
      Get.snackbar("Success!", "Logout Successfully",backgroundColor:Colors.green);
      Future.delayed(Duration(milliseconds: 800), () {
        Get.offAndToNamed("/login_screen");
      });
    } else {
      Get.snackbar("Error", "Dont Logout!!",backgroundColor:Colors.red);
    }
  }
  popupmenu_click(int item)
  {
switch (item) {
  case 0:

    break;
  case 1:
    changeLocale();
    break;
  case 2:
    Get.defaultDialog(
        title:"About" ,
        middleText: "Developer by flutter(Getx) \n"
            "Programmer Mojtaba Behzadi\n"
            "December 2021",
        // set actions for click button
        onConfirm: () {
          Get.back();
        },
        // set custome text for buttons
        textConfirm: "close",
        barrierDismissible: true,
    );
    break;

  case 3:
    logout();
    break;
}
  }
setLocale() async
{
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final SharedPreferences prefs=await _prefs;
  if(prefs.getString("locale")=="en")
  {
    Get.updateLocale( Locale('en','US'));
    prefs.setString("locale", "en");
  }
  else
  {
    Get.updateLocale(Locale('fa','IR'));
    prefs.setString("locale", "fa");
  }
}
changeLocale()async{
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final SharedPreferences prefs=await _prefs;
  if(prefs.getString("locale")=="en")
  {
    Get.updateLocale( Locale('fa','IR'));
    prefs.setString("locale", "fa");
  }
  else
  {
    Get.updateLocale(  Locale('en','US'));
    prefs.setString("locale", "en");
  }
  }
}
