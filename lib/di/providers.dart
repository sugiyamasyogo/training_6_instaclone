import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:training_6_instaclone/models/db/database_manager.dart';
import 'package:training_6_instaclone/models/location/location_manager.dart';
import 'package:training_6_instaclone/models/repositories/user_repository.dart';
import 'package:training_6_instaclone/view_models/login_view_model.dart';

import '../models/repositories/post_rerository.dart';
import '../view_models/feed_view_model.dart';
import '../view_models/post_view_model.dart';

List<SingleChildWidget> globalProvider = [
  ...independentModels,
  ...dependentModels,
  ...viewModels
];

List<SingleChildWidget> independentModels = [
  Provider<DatabaseManager>(
    create: (_) => DatabaseManager(),
  ),
  Provider<LocationManager>(
    create: (_) => LocationManager(),
  ),
];

List<SingleChildWidget> dependentModels = [
  ProxyProvider<DatabaseManager, UserRepository>(
    update: (_, dbManager, repo) => UserRepository(dbManager: dbManager),
  ),
  ProxyProvider2<DatabaseManager, LocationManager, PostRepository>(
    update: (_, dbManager, locationManager, repo) =>
        PostRepository(dbManager: dbManager, locationManager: locationManager),
  ),
];

List<SingleChildWidget> viewModels = [
  ChangeNotifierProvider<LoginViewModel>(
    create: (context) => LoginViewModel(
      userRepository: context.read<UserRepository>(),
    ),
  ),
  ChangeNotifierProvider<PostViewModel>(
    create: (context) => PostViewModel(
      userRepository: context.read<UserRepository>(),
      postRepository: context.read<PostRepository>(),
    ),
  ),
  ChangeNotifierProvider<FeedViewModel>(
    create: (context) => FeedViewModel(
      userRepository: context.read<UserRepository>(),
      postRepository: context.read<PostRepository>(),
    ),
  ),
];
