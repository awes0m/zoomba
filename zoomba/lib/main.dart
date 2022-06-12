/// dev dependencies:
// import "package:flutter_config/flutter_config.dart";
///dependencies:
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:zoomba/screens/history_meeting_screen.dart';
import 'package:zoomba/screens/home_screen.dart';
//screen imports:
import 'package:zoomba/screens/login_screen.dart';
import 'package:zoomba/screens/video_call_screen.dart';
import 'package:zoomba/utils/colors.dart';

import 'resources/auth_methods.dart';
import 'utils/utils.dart';

void main() async {
  if (!kIsWeb) {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBP6nvrDxejazrpSH59al_ZDhSiXvGMOHY",
          authDomain: "zoomba-ho.firebaseapp.com",
          projectId: "zoomba-ho",
          storageBucket: "zoomba-ho.appspot.com",
          messagingSenderId: "1094962438323",
          appId: "1:1094962438323:web:d74896b9ef9688b6ebd0c6",
          measurementId: "G-Z5G2FNTL8V"),
    );
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Zoomba',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: backgroundColor,
        ),
        routes: {
          LoginScreen.routeName: (context) => const LoginScreen(),
          HomeScreen.routeName: (context) => const HomeScreen(),
          VideoCallScreen.routeName: (context) => const VideoCallScreen(),
          HistoryMeetingScreen.routeName: (context) =>
              const HistoryMeetingScreen(),
        },
        home: StreamBuilder(
          stream: AuthMethods().authChanges,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              return const HomeScreen();
            }
            return const LoginScreen();
          },
        ));
  }
}
