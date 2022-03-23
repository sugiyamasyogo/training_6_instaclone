import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:training_6_instaclone/models/db/database_manager.dart';
import 'package:training_6_instaclone/models/location/location_manager.dart';
import 'package:training_6_instaclone/utils/constants.dart';

class PostRepository {
  final  DatabaseManager dbManager;
  final LocationManager locationManager;

  PostRepository({required this.dbManager,required this.locationManager});

  Future<File?> pickImage(UploadType uploadType) async {
    final imagePicker = ImagePicker();

    if (uploadType == UploadType.GALLERY) {
      final pickedImage =
      await imagePicker.pickImage(source: ImageSource.gallery);
      return (pickedImage != null)
          ? File(pickedImage.path)
          : null;
    } else {
      final pickedImage =
      await imagePicker.pickImage(source: ImageSource.camera);
      return (pickedImage != null)
          ? File(pickedImage.path)
          : null;
    }
  }
}