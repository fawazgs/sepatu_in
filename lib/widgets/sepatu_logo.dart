import 'package:flutter/material.dart';
import '/utils/app_theme.dart';

class SepatuLogo extends StatelessWidget {
  final double fontSize;
  final bool underline;
  final FontWeight fontWeight;
  final bool extraBold;

  const SepatuLogo({
    super.key,
    this.fontSize = 22,
    this.underline = false,
    this.fontWeight = FontWeight.w800,
    this.extraBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'Sepatu.in',
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: FontStyle.italic,
        color: AppColors.lime,
        decoration: underline ? TextDecoration.underline : TextDecoration.none,
        decorationColor: AppColors.lime,
        decorationThickness: 2,
        shadows: extraBold
            ? const [
                Shadow(color: AppColors.lime, offset: Offset(0.8, 0)),
                Shadow(color: AppColors.lime, offset: Offset(-0.8, 0)),
              ]
            : null,
      ),
    );
  }
}