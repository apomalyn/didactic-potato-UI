/// THIRD-PARTIES
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

/// SERVICES
import 'core/services/api.dart';
import 'package:UI/core/services/user_repository.dart';
import 'package:UI/core/services/storage_service.dart';

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
  Provider.value(value: StorageService()),
];

/// Services that relies on other services
List<SingleChildWidget> dependentServices = [
  ProxyProvider2<Api, StorageService, UserRepository>(
    update: (_, api, storageService, userRepository) => UserRepository(api: api, storageService: storageService),
  )
];

/// Services that will get something to display
/// Should be a StreamProvider
List<SingleChildWidget> uiConsummableProviders = [
  StreamProvider<User>(
    create: (context) =>
    Provider.of<UserRepository>(context, listen: false).user,
    initialData: null,
  )
];