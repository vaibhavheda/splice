import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splice/widgets/home/home_screen.dart';
import 'package:splice/widgets/settings/settings_page.dart';
import 'package:splice/widgets/url_shortner/url_shortner_screen.dart';
import 'package:splice/widgets/url_shortner_output/url_shortner_output.dart';
import 'utils/themes/theme_manager.dart';
import 'widgets/error/error_screen_Api.dart';

void main() {
  const homePageRoute = URLShortnerScreen.routeName;
  // do computation of initial route here and pass it to my app.
  const SpliceApp spliceApp = SpliceApp(
    homeRoute: homePageRoute,
  );
  return runApp(ChangeNotifierProvider<ThemeNotifier>(
    create: (_) => ThemeNotifier(),
    child: spliceApp,
  ));
}

class SpliceApp extends StatefulWidget {
  final String homeRoute;
  const SpliceApp({Key? key, required this.homeRoute}) : super(key: key);

  @override
  State<SpliceApp> createState() => _SpliceAppState();
}

class _SpliceAppState extends State<SpliceApp> {
  @override
  void initState() {
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, theme, _) => MaterialApp(
        title: 'Splice App',
        theme: theme.getTheme,
        initialRoute: HomeScreen.routeName,
        routes: {
          HomeScreen.routeName: (context) => const HomeScreen(),
          SlicePreferences.routeName: (context) => const SlicePreferences(),
          URLShortnerScreen.routeName: (context) => const URLShortnerScreen(),
          UrlShortnerOutput.routeName: (context) => const UrlShortnerOutput(),
          ErrorScreenAPI.routeName: (context) => const ErrorScreenAPI(),
        },
        // home: const MyHomePage(title: constants.AppConstants.appNameTitle),
      ),
    );
  }
}
