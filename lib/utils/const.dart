import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

const Color blues = Color.fromRGBO(0, 211, 225, 1);
void navigateToPage(BuildContext context, Widget widget) {
  Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: widget));
}
