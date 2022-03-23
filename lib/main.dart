import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:training_6_instaclone/di/providers.dart';
import 'package:training_6_instaclone/style.dart';
import 'package:training_6_instaclone/view/home_screen.dart';
import 'package:training_6_instaclone/view/login/screens/login_screen.dart';
import 'package:training_6_instaclone/view_models/login_view_model.dart';

import 'firebase_options.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
      providers: globalProvider,
      child: MyApp(),),);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginViewModel = Provider.of<LoginViewModel>(context,listen: false);

    return MaterialApp(
      title: 'DaitaInstaglam',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      theme: ThemeData(
          brightness: Brightness.dark,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(primary: Colors.black26),
          ),
          iconTheme: IconThemeData(color: Colors.white),
          fontFamily: RegularFont),
      home: FutureBuilder(
        future: loginViewModel.isSingIn(),
        builder: (context,AsyncSnapshot<bool>snapshot){
          if (snapshot.hasData && snapshot.data == true) {
            return HomeScreen();
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}
