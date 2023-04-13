import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_api/module/authentication/controller/register_controller.dart';
import 'package:login_api/utils/app_string.dart';
import 'package:login_api/utils/custom_text.dart';
import 'package:sizer/sizer.dart';

class OtpPage extends StatelessWidget {
  OtpPage({Key? key}) : super(key: key);
  RegisterController registerController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 10.h),
          TextFormField(
            controller: registerController.otpController,
            decoration: const InputDecoration(border: OutlineInputBorder(), hintText: AppString.enterYourOtp),
          ),
          SizedBox(
            height: 6.h,
          ),
          Obx(() =>  registerController.counter.value == 0
              ? ElevatedButton(
              onPressed: () {


                registerController.resendOtp();

                registerController.postReSendOtp(email: registerController.emailController.text);
              },
              child: CustomText(
                name: AppString.reSendOtp,
              )): Text(
                '${registerController.counter} seconds',
                style: const TextStyle(fontSize: 24),
              )),

          SizedBox(
            height: 6.h,
          ),
          ElevatedButton(
              onPressed: () {
                registerController.postVerifyOtp(otp: registerController.otpController.text, email: registerController.emailController.text);
              },
              child: CustomText(
                name: AppString.verifyOtp,
              )),
        ],
      ),
    );
  }
}
