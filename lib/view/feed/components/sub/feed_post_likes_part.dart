import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:training_6_instaclone/generated/l10n.dart';
import 'package:training_6_instaclone/style.dart';
import 'package:training_6_instaclone/view/comments/screens/comments_screen.dart';

import '../../../../data_models/post.dart';

class FeedPostLikesPart extends StatelessWidget {
  final Post post;

  const FeedPostLikesPart({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                onPressed: null,
                icon: FaIcon(FontAwesomeIcons.solidHeart),
              ),
              IconButton(
                onPressed: () => _openCommentsScreen(context),
                icon: FaIcon(FontAwesomeIcons.comment),
              ),
            ],
          ),
          Text(
            "0 ${S.of(context).likes}",
            style: numberOfLikesTextStyle,
          ),
        ],
      ),
    );
  }

  _openCommentsScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CommentsScreen(
            post: post
        ),
      ),
    );
  }
}
