import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_api/module/authentication/controller/register_controller.dart';
import 'package:login_api/utils/app_string.dart';
import 'package:login_api/utils/custom_text.dart';
import 'package:sizer/sizer.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
 final RegisterController registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
          TextFormField(
            controller: registerController.emailController,
            decoration: const InputDecoration(border: OutlineInputBorder(), hintText: AppString.enterYourEmailId),
          ),
          SizedBox(
            height: 6.h,
          ),
          ElevatedButton(
              onPressed: () {
                registerController.postSendOtp(
                  email: registerController.emailController.text,
                );
              },
              child: CustomText(name: AppString.sendOtp,)),
        ],
      ),
    );
  }
}
