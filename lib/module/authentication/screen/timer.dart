import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpController extends GetxController {
  int _start = 60;
  late Timer _timer;
  bool _isResendEnabled = false;

  int get start => _start;
  bool get isResendEnabled => _isResendEnabled;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_start == 0) {
        _isResendEnabled = true;
        _timer.cancel();
      } else {
        _start--;
        update();
      }
    });
  }

  void resendOtp() {
    _start = 60;
    _isResendEnabled = false;
    startTimer();
    // code to resend OTP
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }
}

class OtpScreen extends StatelessWidget {
  final OtpController _controller = Get.put(OtpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Verification'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Enter the OTP sent to your mobile number',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Obx(() => Text(
              '${_controller.start} seconds',
              style: TextStyle(fontSize: 24),
            )),
            SizedBox(height: 20),
            Obx(() => _controller.isResendEnabled
                ? ElevatedButton(
              onPressed: _controller.resendOtp,
              child: Text(
                'Resend OTP',
                style: TextStyle(color: Colors.blue),
              ),
            )
                : SizedBox()),
          ],
        ),
      ),
    );
  }
}
