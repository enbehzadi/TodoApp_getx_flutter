// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';
import 'package:flutter_app_todo/controller/database_controller.dart';
import 'package:flutter_app_todo/controller/login_controller.dart';
import 'package:flutter_app_todo/controller/task_controller.dart';
import 'package:get/get.dart';
import 'package:progress_indicator_button/progress_button.dart';
import '../constants.dart';
import 'signup_screen.dart';
import 'widget/buttonWidget.dart';
import 'widget/textFieldWidget.dart';
class LoginScreen extends StatelessWidget {
  LoginController logincontroller=Get.put(LoginController());
  var _formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final TaskController taskController=Get.put(TaskController());
    final DatabaseController database=Get.put(DatabaseController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor:Get.isDarkMode ? Colors.black54 : mediumBlue,
        leading:PopupMenuButton<int>(
          onSelected: (item) =>
              taskController.popupmenu_click(item),
          itemBuilder: (context) => [
            PopupMenuItem<int>(value: 0,
              child:
              Obx((){
                return
                  SwitchListTile(
                    value:taskController.idDark.value,
                    title:  Text("Dark".tr),
                    onChanged: (bool value) {
                      database.storeStateDark(value);
                      taskController.changeTheme(database.restoreStateDark());
                    },
                  );


              }),

            ),
            PopupMenuItem<int>(value: 1, child: ListTile(
              leading: const Icon(Icons.translate_outlined),
              title: Text('Language'.tr,style: const TextStyle(fontSize: 13)),

            ),

            ),

            PopupMenuItem<int>(value: 2, child: ListTile(
              leading: const Icon(Icons.account_box_outlined),
              title: Text('About'.tr,style: const TextStyle(fontSize: 13)),
            ),

            ),

          ],
        ),

      ),

      body: _buildBody(),
    );
  }
  Widget _buildBody() {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: new Column(
        children: [
          new Container(
              height: 150,
              alignment: Alignment.center,
              width: double.infinity,
              decoration: new BoxDecoration(
                color: mediumBlue,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
              child: new Text('Login'.tr,
                  style: new TextStyle(
                      color: whiteColor,
                      fontSize: 35,
                      fontWeight: FontWeight.w900))),
          new Container(
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Form(
              key: _formkey,
              child: new Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                new Container(

                    child:TextFieldWidget(validator: (
                    String value
                    ){
                      if(value.isEmpty){
                        return "please enter email".tr;
                      }
                      else if(!GetUtils.isEmail(value))
                        {
                          return "incorrect email".tr;
                        }
                    },
                        controller: logincontroller.email_contoroller,labelText: "Email".tr, icon: Icons.email_outlined)
                ),
                new Container(
                    margin: EdgeInsets.only(top: 10),
                    child:TextFieldWidget(validator: (
                        String value
                        ){
                      if(value.isEmpty){
                        return "please enter password".tr;
                      }
                      else
                      {

                      }
                    },controller: logincontroller.password_contoroller,labelText: "password".tr,
                      icon: Icons.lock_outline,obscureText: true,
                      suffixIcon: Icons.visibility_off,
                    )
                ),
                new Container(
                  margin: EdgeInsets.only(top: 10),
                  child: new Text('Forget Password'.tr,style: new TextStyle(color: mediumBlue),),
                ),
                Container(


                  width: double.infinity,
                  height: 55,
                  child: ProgressButton(

                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    strokeWidth: 2,
                    color:mediumBlue,
                    child: Text(
                      "Login".tr,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                    onPressed: (AnimationController controller) async {
                     if(_formkey.currentState!.validate())
                       {
                         controller.forward();
                         await logincontroller.login( logincontroller.email_contoroller.text,logincontroller.password_contoroller.text);
                         controller.reverse();
                       }
                    },
                  ),
                ),
              InkWell(
              onTap: (){
                Get.to(SignupScreen(),transition: Transition.leftToRight,duration: Duration(seconds: 1));
              },
                child:new Container(
                  margin: EdgeInsets.only(top: 15,bottom: 20),
                  child:
                  ButtonWidget(title: "Sign Up".tr,hasBorder: true,),
                ),
              ),
              ],
            ),


            ),
          )
        ],
      ),
    );
  }
}
