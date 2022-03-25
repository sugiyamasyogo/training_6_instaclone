import 'dart:io';

import 'package:geocoding/geocoding.dart'as geocoding;
import 'package:image_picker/image_picker.dart';
import 'package:training_6_instaclone/data_models/location.dart';
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

  Future<Location>getCurrentLocation() async {
    return await locationManager.getCurrentLocation();
  }

  Future<Location>updateLocation(double latitude, double longitude) async {
    return await locationManager.updateLocation(latitude,longitude);
  }
}