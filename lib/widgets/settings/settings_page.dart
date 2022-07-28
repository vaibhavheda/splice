import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splice/utils/storage_manager/storage_manager.dart';

import '../../constants/constants_strings.dart' as constants;
import '../../utils/themes/theme_manager.dart';

class SlicePreferences extends StatefulWidget {
  static String routeName = "/preferences";

  const SlicePreferences({Key? key}) : super(key: key);

  @override
  State<SlicePreferences> createState() => _SlicePreferencesState();
}

class _SlicePreferencesState extends State<SlicePreferences> {
  late bool _isDarkMode = false;

  @override
  void initState() {
    StorageManager.readData(constants.StorageManagerStrings.themeMode)
        .then((data) {
      String currentMode = data ?? constants.ThemeNames.LIGHT;
      // Set current theme mode.
      setState(() {
        _isDarkMode =
            (currentMode == constants.ThemeNames.LIGHT) ? false : true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, theme, _) => Scaffold(
        appBar: AppBar(
          title: const Text("Preferences"),
          elevation: 0,
          backgroundColor: Theme.of(context).canvasColor,
        ),
        body: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: 24.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.text_fields_rounded),
                      title: const Text("Change Name"),
                      trailing: const Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        //do nothing
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      width: double.infinity,
                      height: 1.0,
                      color: Colors.grey.shade300,
                    ),
                    ListTile(
                      leading: const Icon(Icons.near_me),
                      title: const Text("Change Location"),
                      trailing: const Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        // do nothing
                      },
                    ),
                  ],
                ),
              ),
              // SizedBox(
              //   height: 10.0,
              // ),
              Text(
                "Theme Settings",
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
              ),
              Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 24.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: SwitchListTile(
                  title: const Text(
                    "Dark Mode",
                  ),
                  activeColor: Colors.purple,
                  // contentPadding: const EdgeInsets.all(0),
                  value: _isDarkMode,
                  onChanged: (val) {
                    String newTheme = val
                        ? constants.ThemeNames.DARK
                        : constants.ThemeNames.LIGHT;
                    theme.setTheme(newTheme);
                    setState(() {
                      _isDarkMode = !_isDarkMode;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
