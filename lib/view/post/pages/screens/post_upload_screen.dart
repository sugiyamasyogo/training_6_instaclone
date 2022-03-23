import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_6_instaclone/utils/constants.dart';
import 'package:training_6_instaclone/view_models/post_view_model.dart';

class PostUploadScreen extends StatelessWidget {
  final UploadType uploadType;

  const PostUploadScreen({Key? key, required this.uploadType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final postViewModel = context.read<PostViewModel>();

    if(!postViewModel.isImagePicked && !postViewModel.isProcessing) {
      Future(() => postViewModel.pickImage(uploadType));
    }
    return Scaffold(
      body: Container(),
    );
  }
}
