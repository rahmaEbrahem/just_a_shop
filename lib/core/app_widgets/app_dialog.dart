import 'package:flutter/material.dart';

class AppDialog {
  static Future<dynamic> loadingdialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  static Future<dynamic> error(
    BuildContext context, {
    String message = "Error, Please try again",
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(title: Text("ERROR"), content: Text(message));
      },
    );
  }
}
