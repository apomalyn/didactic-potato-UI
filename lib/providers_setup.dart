/// THIRD-PARTIES
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

/// SERVICES
import 'core/services/api.dart';
import 'package:UI/core/services/user_repository.dart';

/// MODELS
import 'package:UI/core/models/user.dart';

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
List<SingleChildWidget> dependentServices = [
  ProxyProvider<Api, UserRepository>(
    update: (_, api, userRepository) => UserRepository(api: api),
  )
];

/// Services that will get something to display
/// Should be a StreamProvider
List<SingleChildWidget> uiConsummableProviders = [
  StreamProvider<User>(
    create: (context) =>
    Provider.of<UserRepository>(context, listen: false).user,
  )
];