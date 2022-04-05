import 'package:flutter/material.dart';
import 'package:training_6_instaclone/style.dart';
import 'package:training_6_instaclone/view/common/components/circle_photo.dart';

class UserCard extends StatelessWidget {
  final String photoUrl;
  final String title;
  final String subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const UserCard(
      {Key? key, required this.photoUrl,
        required this.title,
        required this.subtitle,
        this.trailing,
        this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.blueGrey,
      onTap: onTap,
      child: ListTile(
        leading: CirclePhoto(
          photoUrl:photoUrl,
          isImageFromFile: false,
        ),
        title: Text(title,style: userCardTitleTextStyle,),
        subtitle: Text(subtitle,style: userCardSubTitleTextStyle,),
      ),

    );
  }
}
