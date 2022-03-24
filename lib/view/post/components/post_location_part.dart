import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:training_6_instaclone/data_models/location.dart';
import 'package:training_6_instaclone/style.dart';
import 'package:training_6_instaclone/view_models/post_view_model.dart';

import '../../../generated/l10n.dart';

class PostLocationPart extends StatelessWidget {
  const PostLocationPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final postViewModel = context.watch<PostViewModel>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(
          postViewModel.locationString,
          style: postLocationTextStyle,
        ),
        subtitle: _latLngPart(postViewModel.location, context),
        trailing: IconButton(
          icon: FaIcon(FontAwesomeIcons.mapMarkerAlt),
          //TODO
          onPressed: null,
        ),
      ),
    );
  }

//TODO
  _latLngPart(Location? location, BuildContext context) {
    const spaceWidth = 8.0;
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Chip(
            label: Text(S.of(context).latitude,),
          ),
          SizedBox(width: spaceWidth,
          ),
          Text((location != null) ? location.latitude.toStringAsFixed(2) : "0.00"),
          SizedBox(width: spaceWidth,
          ),
          Chip(
            label: Text(S.of(context).longitude,),
          ),
          SizedBox(width: spaceWidth,
          ),
          Text((location != null) ? location.longitude.toStringAsFixed(2) : "0.00"),
        ],
    );
  }
}
