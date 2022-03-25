import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart'as geocoding;
import 'package:training_6_instaclone/data_models/location.dart';
import 'package:training_6_instaclone/models/repositories/user_repository.dart';
import 'package:training_6_instaclone/utils/constants.dart';

import '../models/repositories/post_rerository.dart';

class PostViewModel extends ChangeNotifier {
  final UserRepository userRepository;
  final PostRepository postRepository;

  PostViewModel({required this.userRepository,required this.postRepository});

  File? imageFile;

  Location? location;
  String locationString = "";

  String caption = "";

  bool isProcessing = false;
  bool isImagePicked = false;

  Future<void> pickImage(UploadType uploadType) async {
    isImagePicked = false;
    isProcessing = true;
    notifyListeners();

    imageFile = await postRepository.pickImage(uploadType);
    print("pickedImage: ${imageFile?.path}");

    // TODO 位置情報取得
    location = await postRepository.getCurrentLocation();
    locationString = (location != null) ? _toLocationString(location!) : "";
    print("location:${locationString}");

    if (imageFile != null) isImagePicked = true;
    isProcessing = false;
    notifyListeners();
  }

  _toLocationString(Location location) {
    return location.country + " " + location.state + " " + location.city;
  }

  Future<void>updateLocation(double latitude, double longitude) async {
    location = await postRepository.updateLocation(latitude,longitude);
    locationString = (location != null) ? _toLocationString(location!) : "";
    notifyListeners();

  }
}
