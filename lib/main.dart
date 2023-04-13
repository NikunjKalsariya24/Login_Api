import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'utils/routes.dart';

void main() {
  runApp(const DemoApiApp());
}

class DemoApiApp extends StatelessWidget {
  const DemoApiApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: Routes.register,
          getPages: Routes.pages,
        );
      },
    );
  }
}

