import 'package:flutter/material.dart';
import 'package:training_6_instaclone/data_models/post.dart';
import 'package:training_6_instaclone/models/repositories/post_rerository.dart';
import 'package:training_6_instaclone/models/repositories/user_repository.dart';
import 'package:training_6_instaclone/utils/constants.dart';

import '../data_models/user.dart';

class FeedViewModel extends ChangeNotifier {
  final UserRepository userRepository;
  final PostRepository postRepository;

  String caption = "";

  FeedViewModel({required this.userRepository,required this.postRepository});

  bool isProcessing = false;
  List<Post>? posts = [];

  late User feedUser;
  User get currentUser => UserRepository.currentUser!;

  void setUserFeed(FeedMode feedMode, User? user) {
    if (feedMode == FeedMode.FROM_FEED) {
      feedUser = currentUser;
    } else {
      feedUser = user!;

    }
  }


  Future<void>getPosts(FeedMode feedMode) async {
    isProcessing = true;
    notifyListeners();

    posts =  await postRepository.getPosts(feedMode,feedUser);

    isProcessing = false;
    notifyListeners();

  }

  Future<User>getPostUserInfo(String userId) async {
    return await userRepository.getUserById(userId);
  }

 Future<void> updatePost(Type post, FeedMode feedMode) async {
    isProcessing = true;

    await postRepository.updatePost(
      post.copyWith(caption: caption)
    );

    await getPosts(feedMode);

    isProcessing = false;
    notifyListeners();

 }

}

