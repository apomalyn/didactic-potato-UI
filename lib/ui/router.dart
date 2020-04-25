/// FLUTTER AND THIRD PARTIES
import 'package:flutter/material.dart';

/// CONSTANTS
import 'package:UI/core/constants/router_paths.dart';

/// Router of the application
/// See also [RouterPaths]
class Router {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouterPaths.HOME:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(child: Text('Home')),
                ));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text(
                          'Oups! There no page corresponding to ${routeSettings.name}')),
                ));
    }
  }
}
