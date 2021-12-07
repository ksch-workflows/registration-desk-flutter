import 'package:flutter/material.dart';

class DesktopPageRoute extends MaterialPageRoute {
  DesktopPageRoute({required builder}) : super(builder: builder);

  @override
  Duration get transitionDuration => const Duration(milliseconds: 0);
}
