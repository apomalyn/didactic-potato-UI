/// THIRD-PARTIES
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

/// SERVICES
import 'core/services/api.dart';
import 'package:UI/core/services/authentication_service.dart';

/// MODELS
import 'package:firebase_auth/firebase_auth.dart';

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsummableProviders
];

/// Services completely independent
List<SingleChildWidget> independentServices = [
  Provider.value(value: Api()),
  Provider.value(value: AuthenticationService())
];

/// Services that relies on other services
List<SingleChildWidget> dependentServices = [];

/// Services that will get something to display
/// Should be a StreamProvider
List<SingleChildWidget> uiConsummableProviders = [
  StreamProvider<FirebaseUser>(
    create: (context) =>
    Provider.of<AuthenticationService>(context, listen: false).user,
  )
];