// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter_app_todo/controller/signup_controller.dart';
import 'package:get/get.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:progress_indicator_button/progress_button.dart';
import '../constants.dart';
import 'widget/textFieldWidget.dart';
class SignupScreen extends StatelessWidget {
  final SignupController signupcontroller=Get.put(SignupController());
  final _formkey_signup=GlobalKey<FormState>();
  SignupScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _buildBody(),
    );
  }
  Widget _buildBody() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              height: 150,
              alignment: Alignment.center,
              width: double.infinity,
              decoration: BoxDecoration(
                color: mediumBlue,
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
              child: Text('Sign Up'.tr,
                  style: TextStyle(
                      color: whiteColor,
                      fontSize: 35,
                      fontWeight: FontWeight.w900))),
          Container(
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.symmetric(horizontal: 40),

            child: Form(
              key: _formkey_signup,
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextFieldWidget(validator: (
                String value
                )
                {
                  if(value.isEmpty){
                    return "please enter name".tr;
                  }

                },
                    controller: signupcontroller.name_contoroller,labelText: "Name".tr, icon: Icons.app_registration_outlined),
                Container(
                    margin: const EdgeInsets.only(top: 10),

                    child:TextFieldWidget(validator: (
                        String value
                        )
                    {
                      if(value.isEmpty){
                        return "please enter Email".tr;
                      }


                    },
                        controller: signupcontroller.email_contoroller,labelText: "Email".tr, icon: Icons.email)
                )
                ,Container(
                    margin: const EdgeInsets.only(top: 10),
                    child:TextFieldWidget(validator: (
                        String value
                        )
                    {
                      if(value.isEmpty){
                        return "please enter Password".tr;
                      }
                    },
                        controller: signupcontroller.password_contoroller,labelText: "Password".tr, icon: Icons.lock_outline,obscureText: true)
                )

                ,Container(
                    margin: const EdgeInsets.only(top: 10),
                    child:TextFieldWidget(validator: (
                        String value
                        )
                    {
                      if(value.isEmpty){
                        return "please enter Repeat Password".tr;
                      }
                      if(signupcontroller.password_contoroller.text!=signupcontroller.repeat_password_contoroller.text)
                        {
                          return "incompataible passwords".tr;
                        }
                    },
                        controller: signupcontroller.repeat_password_contoroller,labelText: " Repeat Password",obscureText: true, icon: Icons.lock_outline)
                ),

                Container(
                    margin: const EdgeInsets.only(top: 10),
                    child:TextFieldWidget(validator: (
                        String value
                        ){
                      if(value.isEmpty){
                        return "please enter age".tr;
                      }
                      else
                      {

                      }
                    },controller: signupcontroller.age_contoroller,labelText: "Age".tr,
                      icon: Icons.baby_changing_station_sharp,
                    )
                ),

                Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: double.infinity,
                  height: 55,
                  child: ProgressButton(

                    borderRadius: const BorderRadius.all(Radius.circular(8),
                    ),

                    strokeWidth: 2,
                    color:mediumBlue,

                    child: Text(
                      "SignUp".tr,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    onPressed: (AnimationController controller) async {
                     if(_formkey_signup.currentState!.validate())
                       {
                         controller.forward();
                         await signupcontroller.signup(signupcontroller.name_contoroller.text,
                             signupcontroller.email_contoroller.text,signupcontroller.password_contoroller.text,signupcontroller.age_contoroller.text);
                         controller.reverse();
                       }
                    },
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
