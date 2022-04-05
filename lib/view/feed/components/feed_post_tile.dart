import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_6_instaclone/data_models/post.dart';
import 'package:training_6_instaclone/utils/constants.dart';
import 'package:training_6_instaclone/view/feed/components/sub/feed_post_comments_part.dart';
import 'package:training_6_instaclone/view/feed/components/sub/feed_post_header_part.dart';
import 'package:training_6_instaclone/view/feed/components/sub/feed_post_likes_part.dart';
import 'package:training_6_instaclone/view/feed/components/sub/image_from_url.dart';
import 'package:training_6_instaclone/view_models/feed_view_model.dart';

import '../../../data_models/user.dart';

class FeedPostTile extends StatelessWidget {
  final FeedMode feedMode;
  final Post post;

  const FeedPostTile({Key? key, required this.feedMode, required this.post})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final feedViewModel = context.read<FeedViewModel>();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder(
        future: feedViewModel.getPostUserInfo(post.userId),
        builder: (context, AsyncSnapshot<User> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            final postUser = snapshot.data!;
            final currentUser = feedViewModel.currentUser;
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FeedPostHeaderPart(
                  currentUser: currentUser,
                  postUser: postUser,
                  feedMode: feedMode,
                  post: post,
                ),
                ImageFromUrl(
                  imageUrl: post.imageUrl,
                ),
                FeedPostLikesPart(
                  post: post,
                ),
                FeedPostCommentsPart(
                  post: post,
                  postUser: postUser,
                ),
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
