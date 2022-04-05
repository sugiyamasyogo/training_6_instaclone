import 'dart:html';

import 'package:flutter/material.dart';

import '../../../data_models/post.dart';
import '../../../generated/l10n.dart';

class CommentsScreen extends StatelessWidget {

  final Post post;

  const CommentsScreen({Key? key,required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).comments),
      ),
      body: Container(),
    );
  }
}
