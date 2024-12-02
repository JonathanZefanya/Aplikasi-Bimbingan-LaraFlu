import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    checkLoginStatus(); // Memeriksa status login saat splash screen diinisialisasi
  }

  // Fungsi untuk memeriksa status login
  void checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    
    _firebaseMessaging.getToken().then((token) {
      prefs.setString('tokenMobile', token!);
      // Simpan token ini di server Anda untuk mengirim notifikasi
    });

    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    String role = prefs.getString('level') ?? '';

    // Navigasi ke halaman sesuai status login
    if (isLoggedIn) {
      if (role == 'mahasiswa') {
        Timer(const Duration(seconds: 3), () {
          Navigator.pushReplacementNamed(context, '/mahasiswa/home');
        });
      } else if (role == 'dosen') {
        Timer(const Duration(seconds: 3), () {
          Navigator.pushReplacementNamed(context, '/dosen/home');
        });
      }
    } else {
      Timer(const Duration(seconds: 3), () {
        Navigator.pushReplacementNamed(context, '/login');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/logo.png',
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
