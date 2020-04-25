/// FLUTTER AND THIRD-PARTIES
import 'package:flutter/material.dart';

/// ROUTER AND PATHS
import 'package:UI/core/constants/router_paths.dart';
import 'package:UI/ui/router.dart';

/// Theme
import 'package:UI/ui/utils/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightTheme,
      initialRoute: RouterPaths.HOME,
      onGenerateRoute: Router.generateRoute,
    );
  }
}