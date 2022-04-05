import 'dart:io';

import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:image_picker/image_picker.dart';
import 'package:training_6_instaclone/data_models/location.dart';
import 'package:training_6_instaclone/data_models/post.dart';
import 'package:training_6_instaclone/data_models/user.dart';
import 'package:training_6_instaclone/models/db/database_manager.dart';
import 'package:training_6_instaclone/models/location/location_manager.dart';
import 'package:training_6_instaclone/utils/constants.dart';
import 'package:uuid/uuid.dart';

class PostRepository {
  final DatabaseManager dbManager;
  final LocationManager locationManager;

  PostRepository({required this.dbManager, required this.locationManager});

  Future<File?> pickImage(UploadType uploadType) async {
    final imagePicker = ImagePicker();

    if (uploadType == UploadType.GALLERY) {
      final pickedImage =
          await imagePicker.pickImage(source: ImageSource.gallery);
      return (pickedImage != null) ? File(pickedImage.path) : null;
    } else {
      final pickedImage =
          await imagePicker.pickImage(source: ImageSource.camera);
      return (pickedImage != null) ? File(pickedImage.path) : null;
    }
  }

  Future<Location> getCurrentLocation() async {
    return await locationManager.getCurrentLocation();
  }

  Future<Location> updateLocation(double latitude, double longitude) async {
    return await locationManager.updateLocation(latitude, longitude);
  }

  Future<void> post(User currentUser, File imageFile, String caption,
      Location? location, String locationString) async {
    final storageId = Uuid().v1();
    final imageUrl = await dbManager.uploadImageToStorage(imageFile, storageId);
    final post = Post(
      postId: Uuid().v1(),
      userId: currentUser.userId,
      imageUrl: imageUrl,
      imageStoragePath: storageId,
      caption: caption,
      locationString: locationString,
      latitude: (location != null) ? location.latitude : 0.0,
      longitude: (location != null) ? location.longitude : 0.0,
      postDateTime: DateTime.now(),
    );
    await dbManager.insertPost(post);
  }

  Future<List<Post>?>getPosts(FeedMode feedMode, User feedUser) async {
    if (feedMode == FeedMode.FROM_FEED) {
      //TODO 自分＋フォローしているユーザーの投稿を取得
      return dbManager.getPostsMineAndFollowings(feedUser.userId);
    } else {
      //TODO プロフィール画面に表示されているユーザーの投稿を取得
     // return dbManager.getPostsByUser(feedUser.userId)
    }
  }

  Future<void>updatePost(Post updatePost) async {
    return dbManager.updatePost(updatePost);
  }
}
