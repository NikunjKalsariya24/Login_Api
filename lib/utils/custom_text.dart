import 'package:flutter/material.dart';


class CustomText extends StatelessWidget {
  final String? name;
  final Color? color;
  final double? fontSize;
  final TextAlign? textAlign;
  final FontStyle? fontStyle;
  final TextStyle? style;
  final String? fontFamily;
  TextDecoration? decoration;
  FontWeight? fontWeight;

  CustomText(
      {this.name, this.color, this.fontSize, this.textAlign, this.fontStyle, this.fontFamily, this.style, this.decoration, this.fontWeight, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: textAlign ?? TextAlign.start,
      name ?? "",
      style: TextStyle(
        decoration: decoration ?? TextDecoration.none,
        color: color,
        fontSize: fontSize,
        fontStyle: fontStyle,
      //  fontFamily: fontFamily ?? AppString.openSans,
        fontWeight: fontWeight ?? FontWeight.w400,
      ),
    );
  }
}
