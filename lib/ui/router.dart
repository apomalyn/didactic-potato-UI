/// FLUTTER AND THIRD PARTIES
import 'package:flutter/material.dart';

// CONSTANTS
import 'package:UI/core/constants/router_paths.dart';

// VIEWS
import 'package:UI/ui/views/signin_view.dart';
import 'package:UI/ui/views/index_view.dart';
import 'package:UI/ui/views/register_view.dart';

/// Router of the application
/// See [RouterPaths] for the list of available routes
class Router {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouterPaths.HOME:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        child: Text("Sign In"),
                        onPressed: () => Navigator.pushNamed(
                            _, RouterPaths.SIGN_IN),
                      )
                    ],
                  )),
                ));
      case RouterPaths.SIGN_IN:
        return MaterialPageRoute(builder: (_) => SignInView());
      case RouterPaths.INDEX:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
          backgroundColor: Color(0xFFf4a261),
          body: IndexView(),
        ));
      case RouterPaths.ON_BOARDING:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              backgroundColor: Color(0xFFf4a261),
              body: RegisterView(),
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
