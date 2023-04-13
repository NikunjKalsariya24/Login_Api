import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:login_api/network_helper/exception.dart';
import 'package:login_api/utils/api_constance.dart';


class NetworkAPICall {
  static final NetworkAPICall _networkAPICall = NetworkAPICall._internal();

  factory NetworkAPICall() {
    return _networkAPICall;
  }

  static Client get httpClient => InterceptedClient.build(
    interceptors: [
      LoggerInterceptor(),
    ],
    retryPolicy: ExpiredTokenRetryPolicy(),
  );

  NetworkAPICall._internal();

  static String BASE_URL = ApiConstants.BASE_URL;

  Future<http.Response>  post(String url, {dynamic body, Map<String, String>? header}) async {
    try {
      final String fullURL = BASE_URL + url;

      log('API Url: $fullURL', level: 1);
      log('API Url: $fullURL');
      log('body: $body', level: 1);
      log('body: $body');

      final response = await httpClient.post(Uri.parse(fullURL), body: body, headers: header).timeout(
        const Duration(seconds: 20),
        onTimeout: () {
          // Time has run out, do what you wanted to do.
          return http.Response('Error', 408); // Request Timeout respons// e status code
        },
      );
      log("response body--->${response.body}");
      log("response code--->${response.statusCode}");
      log('Response status: ${response.statusCode}');
      // log('Response body: ${response.body.toString()}');

      return response;
    } catch (e, st) {
      print("netwok error--->$e --- $st");
      httpClient.close();
      rethrow;
    }
  }

  Future multipartRequest(String url, Map<String, String> body, String methodName,
      {Map<String, String>? header, File? image, String? imageKey}) async {
    var client = http.Client();
    try {
      String fullURL = BASE_URL + url;

      log('API Url: $fullURL', level: 1);
      // log('API body: $body');
      // log('API header: $header');

      var request = http.MultipartRequest(methodName, Uri.parse(fullURL));
      request.headers.addAll(header!);
      request.fields.addAll(body);
      if (image != null) {
        request.files.add(await http.MultipartFile.fromPath(imageKey!, image.absolute.path));
      }

      http.StreamedResponse response = await request.send();

      // print('Response status: ${response.statusCode}');

      String jsonDataString = await response.stream.bytesToString();
      final jsonData = jsonDecode(jsonDataString);

      // if (jsonData["status"] == "Fail") {
      //   throw AppException(message: jsonData['message'], errorCode: 0);
      // }

      return jsonData;
    } catch (exception) {
      client.close();
      rethrow;
    }
  }

  Future<dynamic> put(String url, {Map<String, String>? header, dynamic body}) async {
    try {
      final String fullURL = BASE_URL + url;

      log('API Url: $fullURL', level: 1);
      //log('API body: $body');

      final response = await httpClient.put(Uri.parse(fullURL), body: body, headers: header).timeout(
        const Duration(seconds: 20),
        onTimeout: () {
          // Time has run out, do what you wanted to do.
          return http.Response('Error', 408); // Request Timeout response status code
        },
      );

      // log('Response status: ${response.statusCode}');
      // log('Response body: ${response.body.toString()}');

      return checkResponse(response);
    } catch (e) {
      httpClient.close();
      rethrow;
    }
  }

  Future<dynamic> postWithCustomURL(String url, dynamic body, {Map<String, String>? header}) async {
    try {
      final String fullURL = url;

      log('API Url: $fullURL', level: 1);
      // log('API body: $body');
      // log('API header: $header');

      final response = await httpClient.post(Uri.parse(fullURL), body: body, headers: header).timeout(
        const Duration(seconds: 20),
        onTimeout: () {
          // Time has run out, do what you wanted to do.
          return http.Response('Error', 408); // Request Timeout response status code
        },
      );

      // log('Response status: ${response.statusCode}');
      // log('Response body: ${response.body.toString()}');

      return checkResponse(response);
    } catch (e) {
      httpClient.close();
      rethrow;
    }
  }

  Future<dynamic> get(String url, {Map<String, String>? header, bool isToken = true}) async {
    try {
      final String fullURL = BASE_URL + url;
      log('API Url: $fullURL');
      log('API header: $header');
      final response = await httpClient
          .get(
        Uri.parse(fullURL),
        headers: header,
      )
          .timeout(
        const Duration(seconds: 20),
        onTimeout: () {
          // Time has run out, do what you wanted to do.
          return http.Response('Error', 408); // Request Timeout response status code
        },
      );
      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');
      return checkResponse(response);
    } catch (e) {
      httpClient.close();
      rethrow;
    }
  }

  Future<dynamic> getS(String url, {Map<String, String>? header, bool isToken = true}) async {
    try {
      final String fullURL = url;
      log('API Url: $fullURL');
      log('API header: $header');
      final response = await httpClient
          .get(
        Uri.parse(fullURL),
        headers: header,
      )
          .timeout(
        const Duration(seconds: 20),
        onTimeout: () {
          // Time has run out, do what you wanted to do.
          return http.Response('Error', 408); // Request Timeout response status code
        },
      );
      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');
      return checkResponse(response);
    } catch (e) {
      httpClient.close();
      rethrow;
    }
  }

  Future<dynamic> getWithCustomURL(String url, {Map<String, String>? header, dynamic body}) async {
    try {
      final String fullURL = url;
      log('API Url: $fullURL');
      // log('API header: $header');
      final response = await httpClient.get(Uri.parse(fullURL), headers: header).timeout(
        const Duration(seconds: 20),
        onTimeout: () {
          // Time has run out, do what you wanted to do.
          return http.Response('Error', 408); // Request Timeout response status code
        },
      );
      return checkResponse(response);
    } catch (e) {
      httpClient.close();
      rethrow;
    }
  }

  dynamic checkResponse(http.Response response) {
    try {
      if (response.body.isEmpty) {
        throw AppException(message: 'Response body is empty', errorCode: 0);
      }
      final json = jsonDecode(utf8.decode(response.bodyBytes));
      bool isSuccess = true;
      try {
        isSuccess = json['success'] ?? false;
      } catch (e) {
        log(e.toString());
      }
      if (response.statusCode == 200) {
        isSuccess = true;
      }
      if (response.statusCode == 500) {
        // throw ToastUtils.Toast(json["error"]["message"],
        //     toastColor: AppColors.primaryColor);
      }
      if (response.statusCode == 400) {
        // throw ToastUtils.Toast(json["error"]["message"],
        //     toastColor: AppColors.primaryColor);
      }
      if (response.statusCode == 401) {
        // throw ToastUtils.Toast(json["error"]["message"],
        //     toastColor: AppColors.primaryColor);
      }

      return json;
    } catch (e) {
      rethrow;
    }
  }
}

class LoggerInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    print(data.toString());
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    if (data.statusCode == 401) {
      // await showGeneralDialog(
      //     pageBuilder: (context, animation1, animation2) {
      //       return const SizedBox();
      //     },
      //     barrierColor: AppColors.black.withOpacity(0.8),
      //     transitionDuration: const Duration(milliseconds: 350),
      //     barrierDismissible: false,
      //     context: Get.context!,
      //     transitionBuilder: (context, a1, a2, widget) => Transform.scale(
      //         scale: a1.value,
      //         child: Opacity(
      //           opacity: a1.value,
      //           child: AlertDialog(
      //             title: const AppText(
      //               text: AppString.sessionExpire,
      //             ),
      //             content: SizedBox(
      //               height: 80,
      //               child: Column(
      //                 children: const [
      //                   AppText(
      //                     text: AppString.yourSessionHasExpirePleaseLoginAgain,
      //                   ),
      //                 ],
      //               ),
      //             ),
      //             actions: [
      //               ElevatedButton(
      //                 child: const AppText(text: AppString.ok),
      //                 onPressed: () {
      //                   AppSharedPreference.clear();
      //                   Get.offAllNamed(Routes.splash);
      //                 },
      //               )
      //             ],
      //           ),
      //         )));
    }
    return data;
  }
}

class ExpiredTokenRetryPolicy extends RetryPolicy {
  @override
  int get maxRetryAttempts => 2;

  @override
  bool shouldAttemptRetryOnException(Exception reason) {
    return false;
  }

  @override
  Future<bool> shouldAttemptRetryOnResponse(ResponseData response) async {
    if (response.statusCode == 401) {
      ///token expire to call
      return true;
    }
    return false;
  }
}
