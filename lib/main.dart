// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:owari/menu/login.dart';
import 'package:owari/menu/register.dart';
import 'package:owari/menu/home.dart';
import 'screen/Category.dart';
import 'package:owari/menu/new_product.dart';
import 'package:owari/menu/new_design.dart';
import 'package:owari/menu/admlog.dart';
import 'package:owari/menu/profile/profile.dart';
import 'package:owari/admin/mainleo.dart';
import 'package:owari/admin/dashboard/dashboard.dart';
import 'package:owari/menu/profile/update_akun.dart';
import 'package:owari/menu/profile/riwayat.dart';
import 'package:owari/menu/profile/wishlist.dart';
import 'package:owari/menu/profile/privacy&policy.dart';
import 'package:owari/menu/profile/tentang.dart';
import 'package:owari/menu/category.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SplashScreen(),
      // home: Category(),
      routes: {
        '/login': (context) => LoginPage(key: UniqueKey()),
        '/register': (context) => RegisterPage(key: UniqueKey()),
        '/home': (context) => HomePage(),
        '/kategori': (context) => Kategori(),
        '/newProduct': (context) => newProduct(),
        '/newDesign': (context) => newDesign(),

        //PROFILLLLLLL
        '/userProfile': (context) => UserProfile(),
        '/updateProfile': (context) => UpdateProfilePage(),
        '/riwayat': (context) => RiwayatPembelian(),
        '/wishlist': (context) => Wishlist(),
        '/kebijakan': (context) => PrivacyAndPolicy(),
        '/tentang': (context) => AboutOwari(),

        //ADMIN ROUTES
        '/adminlogin': (context) => AdminLogin(key: UniqueKey()),
        '/dashboard': (context) => Dashboard(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      // Navigasi ke halaman login/register setelah 3 detik
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Tambahkan logo atau gambar di sini
            Image.asset('assets/logo.png', width: 150, height: 150),
            // const CircularProgressIndicator(),
            // const SizedBox(height: 20),
            // const Text('Loading...'),
          ],
        ),
      ),
    );
  }
}
