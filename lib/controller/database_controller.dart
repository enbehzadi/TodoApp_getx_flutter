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

  void storeStateTranslate(bool translate) {
    box.write('translate', translate);
  }
  bool restoreStateTranslate() {
    final translate = box.read('translate') ?? {};
    return translate;
  }

}
