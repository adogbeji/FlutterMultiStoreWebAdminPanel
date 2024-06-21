import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:multi_store_web_admin/views/screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensures all Flutter widgets have been successfully initialised

  await Firebase.initializeApp(
      options: kIsWeb || Platform.isAndroid
          ? const FirebaseOptions(
              apiKey: 'AIzaSyCV9oi762PMxndTngg5ge3jRG4pIVg43-g',
              appId: '1:647264549373:web:d03874ff40ecc9f72c8194',
              messagingSenderId: '647264549373',
              projectId: 'multi-store-a9a8b',
              storageBucket: 'multi-store-a9a8b.appspot.com',
            )
          : null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainScreen(),
      builder: EasyLoading.init(),  // Makes loading spinner show up on all screens
    );
  }
}
