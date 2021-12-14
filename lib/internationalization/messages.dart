import 'package:get/get.dart';
class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      //login screen
      'Login': 'Login',
      'please enter email': 'please enter email',
      'incorrect email': 'incorrect email',
      'please enter password': 'please enter password',
      'Email': 'Email',
      'password': 'password',
      'Forget Password': 'Forget Password',
      'Sign Up': 'Sign Up',
      "input information carefully!!": 'input information carefully!!',

      //signup screen
      'please enter name': 'please enter name',
      'Name': 'Name',
      'please enter Password': 'please enter Password',
      'please enter Repeat Password': 'please enter Repeat Password',
      'incompataible passwords': 'incompataible passwords',
      'please enter age': 'please enter age',
      'Age': 'Age',

      //task screen
      'Task Screen': 'Task Screen',
      'Description': 'Description',
      'Save': 'Save',

      'Dark': 'Dark',
      'Language': 'Language',
      'About': 'About',
      'Logout': 'Logout',
    },
    'fa_IR': {
      //login screen
      'Login': 'ورود',
      'please enter email': 'لطفا ایمیل را وارد کنید',
      'incorrect email': 'ایمیل اشتباه است',
      'please enter password': 'لطفا رمز عبور را وارد کنید',
      'Email': 'ایمیل',
      'password': 'رمز عبور',
      'Forget Password': 'فراموشی رمز عبور',
      'Sign Up': 'ثبت نام',
      "input information carefully!!": 'اطلاعات را با دقت وارد کنید',
      //signup screen
      'please enter name': 'لطفا نام را وارد کنید',
      'Name': 'نام',
      'please enter Repeat Password': 'لطفا تکرار رمز عبور را وارد کنید',
      'incompataible passwords': 'رمزها برابر نیست',
      'please enter age': 'سن را وارد کنید',
      'Age': 'سن',

      //task screen
      'Task Screen': 'صفحه کارها',
      'Description': 'توضیحات',
      'Save': 'ذخیره',
      'Dark': 'تیره',
      'Language': 'زبان',
      'About': 'درباره',
      'Logout': 'خروج',

    }
  };
}