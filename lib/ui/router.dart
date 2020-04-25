/// FLUTTER AND THIRD PARTIES
import 'package:flutter/material.dart';

/// CONSTANTS
import 'package:UI/core/constants/router_paths.dart';

/// VIEWS
import 'package:UI/ui/views/signin_view.dart';

/// Router of the application
/// See [RouterPaths] for the list of available routes
class Router {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouterPaths.HOME:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Column(
                    children: <Widget>[
                      RaisedButton(
                        child: Text("Sign In"),
                        onPressed: () => Navigator.pushReplacementNamed(_, RouterPaths.SIGN_IN),
                      )
                    ],
                  ),
                ));
      case RouterPaths.SIGN_IN:
        return MaterialPageRoute(builder: (_) => SignInView());
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
