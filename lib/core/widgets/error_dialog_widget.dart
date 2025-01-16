
import 'package:flutter/material.dart';

void showErrorDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('خطا'),
        content: Text(message), // نمایش پیغام خطای واقعی از سرور
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('بستن'),
          ),
        ],
      );
    },
  );
}