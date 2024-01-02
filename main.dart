import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projcet_canhan/constants/theme.dart';
import 'package:projcet_canhan/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:projcet_canhan/screens/auth_ui/welcome/welcome.dart';
import 'package:projcet_canhan/screens/home/home.dart';

// ignore: unused_import
import 'firebase_options.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Projcet Canhan',
      theme: themeData,
      home: StreamBuilder(
        stream: FirebaseAuthHelper.instance.getAuthChange,
        builder: (context, snapshot){
          if (snapshot.hasData){
            return const Home();
          }
          return const Welcome();
        }
      ),
    );
  }
}

