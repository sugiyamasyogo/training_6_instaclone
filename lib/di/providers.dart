import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:training_6_instaclone/models/db/database_manager.dart';
import 'package:training_6_instaclone/models/repositories/user_repository.dart';
import 'package:training_6_instaclone/view_models/login_view_model.dart';

List<SingleChildWidget> globalProvider = [
  ...independentModels,
  ...dependentModels,
  ...viewModels
];

List<SingleChildWidget> independentModels = [
  Provider<DatabaseManager>(
    create: (_) => DatabaseManager(),
  ),
];

List<SingleChildWidget> dependentModels = [
  ProxyProvider<DatabaseManager, UserRepository>(
    update: (_, dbManager, repo) => UserRepository(dbManager: dbManager),
  ),
];

List<SingleChildWidget> viewModels = [
  ChangeNotifierProvider<LoginViewModel>(
    create: (context) => LoginViewModel(
      userRepository: context.read<UserRepository>(),
    ),
  ),
];
