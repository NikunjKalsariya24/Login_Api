import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_api/module/authentication/controller/register_controller.dart';
import 'package:login_api/utils/app_string.dart';
import 'package:login_api/utils/custom_text.dart';
import 'package:sizer/sizer.dart';

class SetPassWord extends StatelessWidget {
  SetPassWord({Key? key}) : super(key: key);
  RegisterController registerController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        SizedBox(
          height: 10.h,
        ),
        TextFormField(
          controller: registerController.passwordController,
          decoration: const InputDecoration(border: OutlineInputBorder(), hintText: AppString.enterPassword),
        ),
        SizedBox(height: 10.h,),
        ElevatedButton(onPressed: () {
          registerController.setPassword(email:registerController.emailController.text ,password: registerController.passwordController.text);
        }, child: CustomText(name: AppString.setPassword,))
      ]),
    );
  }
}
