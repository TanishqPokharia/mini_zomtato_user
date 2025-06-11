import 'package:flutter/cupertino.dart';

extension ResponsiveExtension on BuildContext {
  double get screenHeight => MediaQuery.sizeOf(this).height;
  double get screenWidth => MediaQuery.sizeOf(this).width;
  double rs(double size) => screenHeight * (size / 1000);
}
