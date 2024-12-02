import 'package:bimbingan/screen/auth/login_screen.dart';
import 'package:bimbingan/screen/dosen/home_dosen_screen.dart';
import 'package:bimbingan/screen/mahasiswa/home_mahasiswa_screen.dart';
import 'package:bimbingan/services/firebase_options.dart';
import 'package:bimbingan/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "Bimbingan",
    options: DefaultFirebaseOptions.currentPlatform
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),

        '/mahasiswa/home': (context) => const HomeMahasiswaScreen(),

        '/dosen/home': (context) => const HomeDosenScreen(),
      },
    );
  }
}