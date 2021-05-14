import 'package:flutter/material.dart';

class WebPageRoute extends MaterialPageRoute {
  WebPageRoute({required builder}) : super(builder: builder);

  @override
  Duration get transitionDuration => const Duration(milliseconds: 0);
}