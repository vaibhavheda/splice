import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../home/home_screen.dart';

class ErrorScreenAPI extends StatefulWidget {
  /*
    Route Name: URL Shortner Output
  */
  static const routeName = "/error_screen_api";

  const ErrorScreenAPI({Key? key}) : super(key: key);

  @override
  State<ErrorScreenAPI> createState() => _ErrorScreenAPIState();
}

class _ErrorScreenAPIState extends State<ErrorScreenAPI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).canvasColor,
        leading: IconButton(
          onPressed: () {
            Navigator.popUntil(context, (route) => route.isFirst);
          },
          icon: Icon(Icons.home_outlined),
        ),
        title: Text("Error"),
      ),
      body: SafeArea(
        child: Container(
          child: Text(
            "Error!!!",
          ),
        ),
      ),
    );
  }
}
