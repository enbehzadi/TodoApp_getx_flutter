import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DatabaseController extends GetxController {
  final box = GetStorage();

  Future<void> initStorage() async {
    await GetStorage.init();
  }

  void storeStateDark(bool dark) {
    box.write('dark', dark);
  }
  bool restoreStateDark() {
    final dark = box.read('dark') ?? {};
    return dark;
  }

  void storeStateTranslate(String translate) {
    box.write('translate', translate);
  }
  String restoreStateTranslate() {
    final dark = box.read('translate') ?? {};
    return dark;
  }

}
