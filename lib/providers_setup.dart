/// THIRD-PARTIES
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

/// SERVICES
import 'core/services/api.dart';

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsummableProviders
];

/// Services completely independent
List<SingleChildWidget> independentServices = [
  Provider.value(value: Api()),
];

/// Services that relies on other services
List<SingleChildWidget> dependentServices = [];

/// Services that will get something to display
/// Should be a StreamProvider
List<SingleChildWidget> uiConsummableProviders = [];