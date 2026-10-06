import 'package:flutter/material.dart';

extension Navigation on BuildContext {
  dynamic pushNamed(String route) {
    return Navigator.pushNamed(this, route);
  }

  void pop() {
    return Navigator.pop(this);
  }

  dynamic pushNamedAndRemoveUntil(String route, bool predicate) {
    return Navigator.pushNamedAndRemoveUntil(this, route, (v) => predicate);
  }
}
