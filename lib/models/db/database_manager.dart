import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:training_6_instaclone/data_models/post.dart';

import '../../data_models/user.dart';

class DatabaseManager {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<bool> searchUserInDb(auth.User firebaseUser) async {
    final query = await _db
        .collection("users")
        .where("userId", isEqualTo: firebaseUser.uid)
        .get();
    if (query.docs.length > 0) {
      return true;
    }
    return false;
  }

  Future<void> insertUser(User user) async {
    await _db.collection("users").doc(user.userId).set(user.toMap());
  }

  Future<User> getUserInfoFromDbById(String userId) async {
    final query =
        await _db.collection("users").where("userId", isEqualTo: userId).get();
    return User.fromMap(query.docs[0].data());
  }

  Future<String> uploadImageToStorage(File imageFile, String storageId) async {
    final storageRef = FirebaseStorage.instance.ref().child(storageId);
    final uploadTask = storageRef.putFile(imageFile);
    return uploadTask
        .then((TaskSnapshot snapshot) => snapshot.ref.getDownloadURL());
  }

  Future<void> insertPost(Post post) async {
    await _db.collection("posts").doc(post.postId).set(post.toMap());
  }

  Future<List<Post>> getPostsMineAndFollowings(String userId) async {
    //データの有無を判定
    final query = await _db.collection("posts").get();
    if (query.docs.length == 0) return [];

    var userIds = await getFollowingsUserIds(userId);
    userIds.add(userId);

    final quotient = userIds.length ~/ 10;
    final remainder = userIds.length % 10;
    final numberOfChunks = (remainder == 0) ? quotient : quotient + 1;

    var userIdChunks = <List<String>>[];

    if (quotient == 0) {
      userIdChunks.add(userIds);
    } else if (quotient == 1) {
      userIdChunks.add(userIds.sublist(0, 10));
      userIdChunks.add(userIds.sublist(10, 10 + remainder));
    } else {
      for (int i = 0; i < numberOfChunks - 1; i++) {
        userIdChunks.add(userIds.sublist(i * 10, i * 10 + 10));
      }
      userIdChunks.add(userIds.sublist(
          (numberOfChunks - 1) * 10, (numberOfChunks - 1) * 10 + remainder));
    }
    var results = <Post>[];
    await Future.forEach(userIdChunks, (List<String> userIds) async {
      final tempPosts = await getPostsOfChunkedUsers(userIds);
      tempPosts.forEach((post) {
        results.add(post);
      });
    });

    // await Future.forEach(userIds, (id) async {
    //   await _db.collection("post").where("userId",isEqualTo: id).get().then((value) {
    //     value.docs.forEach((element) {
    //       results.add(Post.fromMap(element.data()));
    //     });
    //   });
    // });
    // return results;
    return results;
  }

  Future<List<Post>> getPostsOfChunkedUsers(List<String> userIds) async {
    var results = <Post>[];
    await _db
        .collection("posts")
        .where("userId", whereIn: userIds)
        .orderBy("postDateTime", descending: true)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        results.add(Post.fromMap(element.data()));
      });
    });
    return results;
  }

  Future<List<String>> getFollowingsUserIds(String userId) async {
    final query = await _db
        .collection("users")
        .doc(userId)
        .collection("followings")
        .get();
    if (query.docs.length == 0) return [];

    var userIds = <String>[];
    query.docs.forEach((id) {
      userIds.add(id.data()["userId"]);
    });
    return userIds;
  }

  Future<void> updatePost(Post updatePost) async {
    final reference = _db.collection("posts").doc(updatePost.postId);
    await reference.update(updatePost.toMap());
  }
}
//TODO
//Future<List<Post>> getPostsByUser(String userId) {}
