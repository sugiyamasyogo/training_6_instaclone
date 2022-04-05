import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training_6_instaclone/data_models/post.dart';
import 'package:training_6_instaclone/data_models/user.dart';
import 'package:training_6_instaclone/utils/constants.dart';
import 'package:training_6_instaclone/view_models/feed_view_model.dart';

import '../../components/feed_post_tile.dart';

class FeedSubPage extends StatelessWidget {
  final FeedMode feedMode;
  final User? feedUser;
  final int index;


  const FeedSubPage({Key? key,required this.feedMode,this.feedUser,required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final feedViewModel = context.read<FeedViewModel>();
    feedViewModel.setUserFeed(feedMode, null);

    Future(() => feedViewModel.getPosts(feedMode));

    return Consumer<FeedViewModel>(
      builder: (_, model, child) {
        if (model.isProcessing) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return (model.posts == null)
              ? Container()
              : ListView.builder(
               itemCount: model.posts!.length,
               itemBuilder: (context,index) {
                 return FeedPostTile(
                   feedMode:feedMode,
                   post: model.posts![index],
                 );
               }
          );
        }
      }
    );
  }
}
