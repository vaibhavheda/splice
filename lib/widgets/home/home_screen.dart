import 'package:flutter/material.dart';
import 'package:splice/widgets/settings/settings_page.dart';
import 'package:splice/widgets/url_shortner/url_shortner_screen.dart';

import '../../constants/constants_strings.dart' as constants;

class HomeScreen extends StatefulWidget {
  static const routeName = "/";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /*
    Function to handle button clicks
  */
  _handleClicks(String routeName) {
    Navigator.pushNamed(context, routeName);
  }

  /*
    Function to build the home screen
   */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text(constants.AppSettingStrings.themes),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
                _handleClicks(SlicePreferences.routeName);
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text(constants.AppConstants.appNameTitle),
        elevation: 0,
        backgroundColor: Theme.of(context).canvasColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 16,
            ),
            Card(
              color: Theme.of(context).canvasColor,
              elevation: 0,
              margin: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 8.0,
              ),
              child: Image.asset(
                'assets/images/homeImage.png',
                fit: BoxFit.contain,
              ),
            ),
            Card(
              elevation: 2.0,
              margin: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 8.0,
              ),
              child: ListTile(
                onTap: () => _handleClicks(URLShortnerScreen.routeName),
                title: Text(
                  "Splice URL",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                leading: Icon(
                  Icons.add_link_rounded,
                  size: 24.0,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
