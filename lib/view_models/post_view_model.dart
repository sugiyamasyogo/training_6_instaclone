import 'dart:io';

import 'package:flutter/material.dart';
import 'package:training_6_instaclone/models/repositories/user_repository.dart';
import 'package:training_6_instaclone/utils/constants.dart';

import '../models/repositories/post_rerository.dart';

class PostViewModel extends ChangeNotifier {
  final UserRepository userRepository;
  final PostRepository postRepository;

  PostViewModel({required this.userRepository,required this.postRepository});

  File? imageFile;

  bool isProcessing = false;
  bool isImagePicked = false;

  Future<void> pickImage(UploadType uploadType) async {
    isImagePicked = false;
    isProcessing = true;
    notifyListeners();

    imageFile = await postRepository.pickImage(uploadType);
    print("pickedImage: ${imageFile?.path}");

    // TODO 位置情報取得

    if (imageFile != null) isImagePicked = true;
    isProcessing = false;
    notifyListeners();
  }
}
