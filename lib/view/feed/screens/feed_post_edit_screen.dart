import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_6_instaclone/generated/l10n.dart';
import 'package:training_6_instaclone/utils/constants.dart';
import 'package:training_6_instaclone/view/common/components/user_card.dart';
import 'package:training_6_instaclone/view/common/dialog/confirm_dialog.dart';
import 'package:training_6_instaclone/view/post/components/post_caption_part.dart';
import 'package:training_6_instaclone/view_models/feed_view_model.dart';

import '../../../data_models/post.dart';
import '../../../data_models/user.dart';

class FeedPostEditScreen extends StatelessWidget {
  final Post post;
  final User postUser;
  final FeedMode feedMode;

  const FeedPostEditScreen(
      {Key? key,
      required this.post,
      required this.postUser,
      required this.feedMode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<FeedViewModel>(builder: (_, model, child) {
      return Scaffold(
        appBar: AppBar(
          leading: model.isProcessing
              ? Container()
              : IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close),
                ),
          title: model.isProcessing
              ? Text(S.of(context).underProcessing)
              : Text(S.of(context).editInfo),
          actions: [
            model.isProcessing
                ? Container()
                : IconButton(
                    onPressed: () => showConfirmDialog(
                        context: context,
                        title: S.of(context).editPost,
                        content: S.of(context).editPostConfirm,
                        onConfirmed: (isoConfirmed) {
                          if (isoConfirmed) {
                            _updatePost(context);
                          }
                        }),
                    icon: Icon(Icons.done),
                  ),
          ],
        ),
        body: model.isProcessing
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    UserCard(
                      photoUrl: postUser.photoUrl,
                      title: postUser.inAppUserName,
                      subtitle: post.locationString,
                      onTap: null,
                    ),
                    PostCaptionPart(
                      from: PostCaptionOpenMode.FROM_FEED,
                      post: post,
                    )
                  ],
                ),
              ),
      );
    });
  }

  void _updatePost(BuildContext context) async {
    final feedViewModel = context.read<FeedViewModel>();
    await feedViewModel.updatePost(Post, feedMode);
    Navigator.pop(context);
  }
}
