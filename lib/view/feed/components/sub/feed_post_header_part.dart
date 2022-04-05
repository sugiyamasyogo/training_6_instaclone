import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:training_6_instaclone/generated/l10n.dart';
import 'package:training_6_instaclone/utils/constants.dart';
import 'package:training_6_instaclone/view/common/components/user_card.dart';
import 'package:training_6_instaclone/view/feed/screens/feed_post_edit_screen.dart';

import '../../../../data_models/post.dart';
import '../../../../data_models/user.dart';

class FeedPostHeaderPart extends StatelessWidget {
  final User postUser;
  final Post post;
  final User currentUser;
  final FeedMode feedMode;

  const FeedPostHeaderPart(
      {Key? key,
      required this.postUser,
      required this.post,
      required this.currentUser,
      required this.feedMode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return UserCard(
      photoUrl: postUser.photoUrl,
      title: postUser.inAppUserName,
      subtitle: post.locationString,
      onTap: null,
      //TODO
      trailing: PopupMenuButton(
        icon: Icon(Icons.more_vert),
        onSelected: (PostMenu value) => _onPopupMenuSelected(context, value),
        itemBuilder: (context) {
          if (postUser.userId == currentUser.userId) {
            return [
              PopupMenuItem(
                value: PostMenu.EDIT,
                child: Text(S.of(context).edit),
              ),
              PopupMenuItem(
                value: PostMenu.DELETE,
                child: Text(S.of(context).delete),
              ),
              PopupMenuItem(
                value: PostMenu.SHARE,
                child: Text(S.of(context).share),
              ),
            ];
          } else {
            return [
              PopupMenuItem(
                value: PostMenu.SHARE,
                child: Text(S.of(context).share),
              ),
            ];
          }
        },
      ),
    );
  }

  //TODO
  _onPopupMenuSelected(BuildContext context, PostMenu selectedMenu) {
    switch (selectedMenu) {
      case PostMenu.EDIT:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => FeedPostEditScreen(
              post: post,
              postUser: postUser,
              feedMode: feedMode,
            ),
          ),
        );
        break;
      case PostMenu.SHARE:
        Share.share(post.imageUrl,subject: post.caption);
        break;
    }
  }
}
