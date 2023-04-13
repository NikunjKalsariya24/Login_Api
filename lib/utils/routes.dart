import 'package:get/get.dart';
import 'package:login_api/module/authentication/screen/login_page.dart';
import 'package:login_api/module/authentication/screen/otp.dart';
import 'package:login_api/module/authentication/screen/register.dart';
import 'package:login_api/module/authentication/screen/set_password.dart';


mixin Routes {
  static const defaultTransition = Transition.rightToLeft;
  static const String register = '/Register';
  static const String otpPage = '/OtpPage';
  static const String logInPage = '/LogInPage';
  static const String setPassWord = '/SetPassWord';

  static List<GetPage<dynamic>> pages = [
    GetPage(
      name: register,
      page: () => RegisterScreen(),
    ),
    GetPage(
      name: otpPage,
      page: () => OtpPage(),
    ),
    GetPage(
      name: logInPage,
      page: () => LogInPage(),
    ),
    GetPage(
      name: setPassWord,
      page: () => SetPassWord(),
    ),
  ];
}
