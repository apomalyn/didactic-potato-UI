// FLUTTER AND THIRD PARTIES
import 'package:UI/core/models/user.dart';
import 'package:UI/ui/views/on_boarding_tags_view.dart';
import 'package:UI/ui/views/on_boarding_user_type.dart';
import 'package:flutter/material.dart';

// CONSTANTS
import 'package:UI/core/constants/router_paths.dart';

// VIEWS
import 'package:UI/ui/views/signin_view.dart';
import 'package:UI/ui/views/index_view.dart';
import 'package:UI/ui/views/on_boarding_account_view.dart';
import 'package:UI/ui/views/account_view.dart';
import 'package:provider/provider.dart';

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
                      Provider.of<User>(_) == null ? Text(""):Text("Hello ${Provider.of<User>(_).firstname}"),
                      RaisedButton(
                        child: Text("Sign In"),
                        onPressed: () =>
                            Navigator.pushNamed(_, RouterPaths.SIGN_IN),
                      ),
                      RaisedButton(
                        child: Text("Index"),
                        onPressed: () =>
                            Navigator.pushNamed(_, RouterPaths.INDEX),
                      ),
                      RaisedButton(
                        child: Text("Account"),
                        onPressed: () =>
                            Navigator.pushNamed(_, RouterPaths.ACCOUNT),
                      ),
                      RaisedButton(
                        child: Text("Onboarding account"),
                        onPressed: () =>
                            Navigator.pushNamed(_, RouterPaths.ON_BOARDING_ACCOUNT),
                      ),
                      RaisedButton(
                        child: Text("Onboarding tags"),
                        onPressed: () =>
                            Navigator.pushNamed(_, RouterPaths.ON_BOARDING_TAGS),
                      ),
                      RaisedButton(
                        child: Text("Onboarding type"),
                        onPressed: () =>
                            Navigator.pushNamed(_, RouterPaths.ON_BOARDING_TYPE),
                      )
                    ],
                  )),
            ));
      case RouterPaths.SIGN_IN:
        return MaterialPageRoute(builder: (_) => SignInView());
      case RouterPaths.INDEX:
        return MaterialPageRoute(builder: (_) => IndexView());
      case RouterPaths.ON_BOARDING_ACCOUNT:
        return MaterialPageRoute(builder: (_) => OnBoardingAccountView(routeSettings.arguments));
      case RouterPaths.ON_BOARDING_TAGS:
        return MaterialPageRoute(builder: (_) => OnBoardingTagsView(routeSettings.arguments));
      case RouterPaths.ON_BOARDING_TYPE:
        return MaterialPageRoute(builder: (_) => OnBoardingUserTypeView());
      case RouterPaths.ACCOUNT:
        return MaterialPageRoute(builder: (_) => AccountView());
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