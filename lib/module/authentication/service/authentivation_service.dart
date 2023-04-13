import 'dart:developer';

import 'package:login_api/network_helper/network_helper.dart';

class SendOtpService {
  static final NetworkAPICall _networkAPICall = NetworkAPICall();

  SendOtpService();

  static Future sendOtp({String? email}) async {
    try {
      final result = await _networkAPICall.post("auth/register?email=$email");

      log("ResultRoundModel result ---> ${result.statusCode}");

      return result.statusCode;
    } catch (e, st) {
      log("resultService=========$e $st");
      rethrow;
    }
  }

  static Future ResendOtp({String? email}) async {
    try {
      final result = await _networkAPICall.post("auth/reSendOTP?email=$email");

      log("ResultRoundModel result ---> ${result.statusCode}");

      return result.statusCode;
    } catch (e, st) {
      log("resultService=========$e $st");
      rethrow;
    }
  }

  static Future verifyOtp({String? email, String? otp}) async {
    try {
      final result = await NetworkAPICall().post("auth/verifyOTP?email=$email&otp=$otp");

      log("ResultRoundModel result ---> ${result.statusCode}");

      return result.statusCode;
    } catch (e, st) {
      log("resultService=========$e $st");
      rethrow;
    }
  }


  static Future setPassword({String? email, String? password}) async {
    try {
      final result = await NetworkAPICall().post("auth/setPassword?email=$email&password=$password");

      log("ResultRoundModel result ---> ${result.statusCode}");

      return result.statusCode;
    } catch (e, st) {
      log("resultService=========$e $st");
      rethrow;
    }
  }





}
