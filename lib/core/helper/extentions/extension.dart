import 'package:flutter/material.dart';

extension Navigation on BuildContext {
  dynamic pushNamed(String route) {
    return Navigator.pushNamed(this, route);
  }

  void pop() {
    return Navigator.pop(this);
  }

  dynamic pushNamedAndRemoveUntil(String route, RoutePredicate predicate) {
    return Navigator.pushNamedAndRemoveUntil(this, route, predicate);
  }

  void pushReplacemetNamed(String route) {
    Navigator.pushReplacementNamed(this, route);
  }
}
