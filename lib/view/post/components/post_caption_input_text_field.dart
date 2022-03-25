import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_6_instaclone/generated/l10n.dart';
import 'package:training_6_instaclone/style.dart';
import 'package:training_6_instaclone/view_models/post_view_model.dart';

class PostCaptionInputTextField extends StatefulWidget {



   const PostCaptionInputTextField({Key? key}) : super(key: key);

  @override
  State<PostCaptionInputTextField> createState() => _PostCaptionInputTextFieldState();
}

class _PostCaptionInputTextFieldState extends State<PostCaptionInputTextField> {

  final _captionController = TextEditingController();

  @override
  void initState() {
    _captionController.addListener(_onCaptionUpdated);
    super.initState();
  }
  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.multiline,
      maxLines: null,
      controller: _captionController,
      style: postCaptionTextStyle,
      autofocus: true,
      decoration: InputDecoration(
        hintText: S.of(context).inputCaption,
        border: InputBorder.none,
      ),

    );
  }

  _onCaptionUpdated(){
    final viewModel = context.read<PostViewModel>();
    viewModel.caption = _captionController.text;
    print("caption:${viewModel.caption}");

  }
}
