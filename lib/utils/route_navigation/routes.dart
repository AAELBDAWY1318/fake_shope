import 'package:flutter/material.dart';

void pushReplacement(BuildContext context, {required Widget page}) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => page,
    ),
  );
}

void push(BuildContext context, {required Widget page}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => page,
    ),
  );
}

void pop(BuildContext context) {
  Navigator.pop(context);
}

void pushAndRemoveAll(BuildContext context, {required Widget page}) {
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
    return page;
  }), (route) => false);
}
