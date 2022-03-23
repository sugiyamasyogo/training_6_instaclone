import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:training_6_instaclone/utils/constants.dart';
import 'package:training_6_instaclone/view/common/components/button_with_icon.dart';
import 'package:training_6_instaclone/view/post/pages/screens/post_upload_screen.dart';

import '../../../generated/l10n.dart';

class PostPage extends StatelessWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ButtonWithIcon(
              iconData: FontAwesomeIcons.images,
              label: S.of(context).gallery,
              onPressed: () =>
                  _openPostUploadScreen(UploadType.GALLERY, context), //TODO
            ),
            SizedBox(
              height: 20.0,
            ),
            ButtonWithIcon(
              iconData: FontAwesomeIcons.camera,
              label: S.of(context).camera,
              onPressed: () =>
                  _openPostUploadScreen(UploadType.CAMERA, context), //TODO
            ),
          ],
        ),
      )),
    );
  }

  _openPostUploadScreen(UploadType uploadType, BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PostUploadScreen(uploadType: uploadType),
      ),
    );
  }
}
