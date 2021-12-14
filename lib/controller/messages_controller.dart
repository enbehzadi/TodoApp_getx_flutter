import 'dart:ui';

import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// ignore: camel_case_types
class MessagesController extends GetxController {
  void changeMessages(_language_code,_country_code)
  {
    Get.updateLocale(Locale(_language_code,_country_code));
  }
}


