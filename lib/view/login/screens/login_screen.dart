import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:training_6_instaclone/style.dart';
import 'package:training_6_instaclone/view_models/login_view_model.dart';

import '../../../generated/l10n.dart';
import '../../common/components/button_with_icon.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(S.of(context).appTitle,
            style: loginTitleTextStyle,
            ),
            SizedBox(height: 20.0,),
            ButtonWithIcon(
              iconData: FontAwesomeIcons.signInAlt,
              label: S.of(context).signIn,
              onPressed: ()=> logIn(context),
            ),
          ],
        ),
      ),
    );
  }

  logIn(BuildContext context) async {
    final loginViewModel = context.read<LoginViewModel>();
    await loginViewModel.signIn();
    //TODO
  }
}
