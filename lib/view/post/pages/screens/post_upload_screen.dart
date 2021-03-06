import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_6_instaclone/generated/l10n.dart';
import 'package:training_6_instaclone/utils/constants.dart';
import 'package:training_6_instaclone/view/common/dialog/confirm_dialog.dart';
import 'package:training_6_instaclone/view_models/post_view_model.dart';

import '../../components/post_caption_part.dart';
import '../../components/post_location_part.dart';

class PostUploadScreen extends StatelessWidget {
  final UploadType uploadType;

  const PostUploadScreen({Key? key, required this.uploadType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final postViewModel = context.read<PostViewModel>();

    if (!postViewModel.isImagePicked && !postViewModel.isProcessing) {
      Future(() => postViewModel.pickImage(uploadType));
    }
    return Consumer<PostViewModel>(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            leading: model.isProcessing
                ? Container()
                : IconButton(
                    onPressed: () => _cancelPost(context),
                    icon: Icon(Icons.arrow_back)),
            title: model.isProcessing
                ? Text(S.of(context).underProcessing)
                : Text(S.of(context).post),
            actions: [
              (model.isProcessing || !model.isImagePicked)
                  ? IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => _cancelPost(context),
                    )
                  : IconButton(
                      icon: Icon(Icons.done),
                      //ダイアログ出して投稿処理
                      onPressed: () => showConfirmDialog(
                          context: context,
                          title: S.of(context).post,
                          content: S.of(context).postConfirm,
                          onConfirmed: (isConfirmed){
                            if (isConfirmed){
                              _post(context);
                            }
                          }
                      ),
                    ),
            ],
          ),
          body: model.isProcessing
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : model.isImagePicked
                  ? Column(
                      children: [
                        Divider(),
                        PostCaptionPart(
                          from: PostCaptionOpenMode.FROM_POST,
                        ),
                        Divider(),
                        PostLocationPart(),
                        Divider(),
                      ],
                    )
                  : Container(),
        );
      },
    );
  }

  _cancelPost(BuildContext context)  {
    final postViewModel = context.read<PostViewModel>();
     postViewModel.cancelPost();
    Navigator.pop(context);
  }

  void _post(BuildContext context) async {
    final postViewModel = context.read<PostViewModel>();
    await postViewModel.post();
    Navigator.pop(context);
  }
}
