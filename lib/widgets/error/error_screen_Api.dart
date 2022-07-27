import 'package:flutter/material.dart';

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
        child: SingleChildScrollView(
          child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50.0,
                ),
                Card(
                  color: Theme.of(context).canvasColor,
                  elevation: 0,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 52.0,
                    vertical: 8.0,
                  ),
                  child: Image.asset(
                    'assets/images/error.png',
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Card(
                  elevation: 0,
                  child: Text(
                    "Boooh! Something spilled over.",
                    style: TextStyle(fontSize: 24.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
