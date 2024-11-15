import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wedding_organizer/pages/auth/Login_Register_Screen.dart';
import 'package:wedding_organizer/pages/nav/BottomNavBar.dart';
import 'package:wedding_organizer/pages/Vendor_page/bands/wedding_band.dart';
import 'package:wedding_organizer/pages/Vendor_page/decorations/decoration.dart';

import 'pages/Vendor_page/photographers/photographer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
    apiKey: 'AIzaSyAjX3rgR1sG4L_38P_T6FPrgEkhvOOnvDw',
    appId: '1:766178446819:android:7f168c4451622365f7a4d6',
    messagingSenderId: '766178446819',
    projectId: 'wedding-organizer-ad78e',
    storageBucket: 'wedding-organizer-ad78e.firebasestorage.app',));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  MyApp({super.key});
  Future<bool> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (!isLoggedIn){
      return FirebaseAuth.instance.currentUser != null;}
    return isLoggedIn;
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [FirebaseAnalyticsObserver(analytics: analytics),],
      routes: {
    '/photographersList': (context) => PhotographerList(),
    '/decorationsList': (context) => DecorationList(),
    '/weddingBandsList': (context) => WeddingBandList(),
  },
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent),
        useMaterial3: true,
      ),
      home: FutureBuilder<bool>(
        future: checkLoginStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            if (snapshot.data == true) {
              return BottomScreen();
            } else {
              return LoginRegisterPage();
            }
          }
        },
      ),
    );
  }
}

