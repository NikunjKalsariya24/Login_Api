import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_api/model/login_model.dart';
import 'package:login_api/module/authentication/service/authentivation_service.dart';
import 'package:login_api/utils/routes.dart';
import 'package:login_api/utils/sharepharefrance.dart';

class RegisterController extends GetxController {
  RxBool isLoading = false.obs;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  RxBool isEnabled = true.obs;
  RxInt counter = 6.obs;

  Rx<LogInModel> loginModel = LogInModel().obs;

  timer() {
    Timer.periodic(const Duration(seconds: 1), (_) {
      if (counter.value != 0) {
        counter.value--;
      } else {
        isEnabled.value = true;
      }
    });
  }

  void resendOtp() {
    counter.value = 5;
    isEnabled.value = false;
  }

  Future postSendOtp({String? email}) async {
    try {
      isLoading.value = true;
      final result = await SendOtpService.sendOtp(email: email);
      log("sendotpResult=================${result}");
      if (result == 201) {
        Get.toNamed(
          Routes.otpPage,
        );
        timer();
      } else {
        Get.snackbar("Enter Email ID ", "Then Register Id ", backgroundColor: Colors.deepOrange, snackPosition: SnackPosition.TOP);
      }
      isLoading.value = false;
    } catch (e, st) {
      log("eroorSendOtp=============$e $st");
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future postReSendOtp({String? email}) async {
    try {
      isLoading.value = true;
      final result = await SendOtpService.ResendOtp(email: email);
      log("sendotpResult=================${result}");
      if (result == 200) {
        Get.snackbar("send otp ", "send otp success ", backgroundColor: Colors.deepOrange, snackPosition: SnackPosition.TOP);
      } else {
        Get.snackbar("Enter Email ID ", "Then Register Id ", backgroundColor: Colors.deepOrange, snackPosition: SnackPosition.TOP);
      }
      isLoading.value = false;
    } catch (e, st) {
      log("eroorSendOtp=============$e $st");
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future postVerifyOtp({String? email, String? otp}) async {
    try {
      isLoading.value = true;
      final result = await SendOtpService.verifyOtp(email: email, otp: otp);
      log("verifyotp=================${result}");
      if (result == 200) {
        otpController.clear();
        Get.toNamed(Routes.setPassWord);
      } else if (result == 201) {
        Get.snackbar(" createdD ", "createdD ", backgroundColor: Colors.deepOrange, snackPosition: SnackPosition.TOP);
      } else if (result == 401) {
        Get.snackbar(" Unauthorized ", "Unauthorized ", backgroundColor: Colors.deepOrange, snackPosition: SnackPosition.TOP);
      } else if (result == 403) {
        Get.snackbar(" Forbidden ", "Forbidden ", backgroundColor: Colors.deepOrange, snackPosition: SnackPosition.TOP);
      } else if (result == 404) {
        Get.snackbar(" Not Found ", "Not Found ", backgroundColor: Colors.deepOrange, snackPosition: SnackPosition.TOP);
      } else {
        Get.snackbar("otp not valid ", "otp not valid  ", backgroundColor: Colors.deepOrange, snackPosition: SnackPosition.TOP);
      }
      isLoading.value = false;
    } catch (e, st) {
      log("eroorverifyotp=============$e $st");
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future setPassword({String? email, String? password}) async {
    try {
      isLoading.value = true;
      final result = await SendOtpService.setPassword(email: email, password: password);
      log("sendotpResult=================${result}");
      if (result == 200) {
        Get.snackbar("Password Set success ", "Password Set success ", backgroundColor: Colors.deepOrange, snackPosition: SnackPosition.TOP);
        AppPreference.setString("token", loginModel.value.apiresponse?.data?.token.toString()??"");
        Get.toNamed(Routes.logInPage, arguments: loginModel.value);
      } else {
        Get.snackbar("Enter valid Password ", "enter valid password ", backgroundColor: Colors.deepOrange, snackPosition: SnackPosition.TOP);
      }

      isLoading.value = false;

      print("loginMOdel===============${loginModel.value}");
      return loginModel.value;
    } catch (e, st) {
      log("eroorSendOtp=============$e $st");
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }
}
