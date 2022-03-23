import 'package:flutter/material.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text("FeedPage",style: TextStyle(fontSize: 30.0),),
        ),
      ),
      //bottomNavigationBar: BottomNavigationBar(items: items),
    );
  }
}
