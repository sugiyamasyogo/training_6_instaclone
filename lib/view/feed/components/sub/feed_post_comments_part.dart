import 'package:flutter/material.dart';
import 'package:training_6_instaclone/data_models/user.dart';
import 'package:training_6_instaclone/style.dart';
import 'package:training_6_instaclone/utils/functions.dart';
import 'package:training_6_instaclone/view/common/comment_rich_text.dart';

import '../../../../data_models/post.dart';
import '../../../../generated/l10n.dart';

class FeedPostCommentsPart extends StatelessWidget {
  final Post post;
  final User postUser;

  const FeedPostCommentsPart(
      {Key? key, required this.post, required this.postUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //TODO 投稿者名とキャプション
          CommentRichText(name: postUser.inAppUserName, text: post.caption),
          InkWell(
            onTap: null,
            child: Text(
              "0 ${S.of(context).comments}",
              style: numberOfCommentsTextStyle,
            ),
          ),
          Text(
            createTimeAgoString(post.postDateTime),
            style: timeAgoTextStyle,
          )
        ],
      ),
    );
  }
}
