import 'package:TodoApp2/controller/splash_controller.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:get/get.dart';
class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return Scaffold(
      body: _buildBody(),
      backgroundColor:mediumBlue,
    );
  }
  Widget _buildBody() {

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Align(
          alignment: Alignment.center,
        child:
        Text("TodoApp",
          style: TextStyle(fontSize: 35,color: Colors.white,
          fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,),
        )
    ],
    );
  }


}
