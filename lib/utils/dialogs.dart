import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Dialogs {
  static void alert(BuildContext context,
      {String title = '', String message: ''}) {
    FocusScope.of(context).requestFocus(new FocusNode());
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            ElevatedButton(
              child: Text("Aceptar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  static void confirm(BuildContext context,
      {String title = "",
      String message = "",
      VoidCallback onCancel,
      VoidCallback onConfirm}) {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            content: Text(
              message,
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15),
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                onPressed: onCancel,
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.red),
                ),
              ),
              CupertinoDialogAction(
                onPressed: onConfirm,
                child: Text("OK"),
              ),
            ],
          );
        });
  }

  static showLoaderDialog(BuildContext context, String message) {
    FocusScope.of(context).requestFocus(new FocusNode());
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Expanded(
            child: Container(
                margin: EdgeInsets.only(left: 7), child: Text(message)),
          ),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
