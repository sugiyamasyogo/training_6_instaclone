import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:training_6_instaclone/generated/l10n.dart';
import 'package:training_6_instaclone/style.dart';
import 'package:training_6_instaclone/utils/constants.dart';
import 'package:training_6_instaclone/view/feed/pages/sub/feed_sub_page.dart';
import 'package:training_6_instaclone/view/post/pages/screens/post_upload_screen.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: FaIcon(FontAwesomeIcons.cameraRetro),
          onPressed: () => _launchCamera(context),
        ),
        title: Text(S.of(context).appTitle,style: TextStyle(fontFamily: TitleFont),),
      ),
      body: FeedSubPage(
        feedMode: FeedMode.FROM_FEED, index: 0,
      ),
      //bottomNavigationBar: BottomNavigationBar(items: items),
    );
  }

  _launchCamera(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PostUploadScreen(uploadType: UploadType.CAMERA),
      ),
    );
  }
}
