// ignore_for_file: unused_import

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class User {
  final String id;
  final String email;
  final String password;
  final String name;
  final String phoneNumber;
  final String address;

  User({
    required this.id,
    required this.email,
    required this.password,
    required this.name,
    required this.phoneNumber,
    required this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['nama'],
      email: json['email'],
      password: json['password'],
      phoneNumber: json['telp'],
      address: json['alamat'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'nama': name,
      'telp': phoneNumber,
      'alamat': address,
    };
  }
}

class _UserProfileState extends State<UserProfile> {
  User? user;

  @override
  void initState() {
    super.initState();
    checkUserLoggedIn();
    refreshUserData();
  }

  Future<void> checkUserLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userString = prefs.getString('user');
    if (userString != null) {
      final userMap = jsonDecode(userString);
      setState(() {
        user = User.fromJson(userMap);
      });
    } else {
      goToLoginPage();
    }
  }

  void goToLoginPage() {
    Navigator.popAndPushNamed(context, '/login');
  }

  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
    await prefs.remove('isLoggedIn');
    goToLoginPage();
  }

  int _selectedIndex = 2;
  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      Navigator.pushNamed(context, '/home');
    } else if (index == 1) {
      Navigator.pushNamed(context, '/kategori');
    } else if (index == 2) {
      Navigator.pushNamed(context, '/userProfile');
    }
  }

  Future<void> refreshUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userString = prefs.getString('user');
    if (userString != null) {
      final userMap = jsonDecode(userString);
      setState(() {
        user = User.fromJson(userMap);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Tampilkan halaman UserProfile dengan informasi pengguna
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 250,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  SizedBox(
                      width: 120,
                      height: 120,
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/banner2.png'),
                      )),
                  const SizedBox(height: 10),
                  Center(
                    child: Text(
                      '${user!.name}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Center(
                    child: Text(
                      '${user!.email}',
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),
            // const Divider(),

            //menuuu
            Expanded(
              child: Column(
                children: [
                  customListTile(
                    icon: Icons.people_outline,
                    text: "Informasi Akun",
                    onTap: () => Navigator.pushNamed(context, '/updateProfile'),
                  ),
                  const SizedBox(height: 10),
                  customListTile(
                    icon: Icons.add_shopping_cart_sharp,
                    text: "Keranjang Saya",
                    onTap: () => Navigator.pushNamed(context, '/riwayat'),
                  ),
                  // const SizedBox(height: 10),
                  // customListTile(
                  //   icon: Icons.favorite_border_outlined,
                  //   text: "Wishlist",
                  //   onTap: () => Navigator.pushNamed(context, '/wishlist'),
                  // ),
                  const SizedBox(height: 10),
                  customListTile(
                    icon: Icons.privacy_tip_outlined,
                    text: "Kebijakan dan Privacy",
                    onTap: () => Navigator.pushNamed(context, '/kebijakan'),
                  ),
                  const SizedBox(height: 10),
                  customListTile(
                    icon: Icons.info_outline,
                    text: "About Owari",
                    onTap: () => Navigator.pushNamed(context, '/tentang'),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: customListTile(
                        icon: Icons.logout,
                        text: "Logout",
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Logout Akun'),
                                content:
                                    Text('Apakah Anda yakin ingin keluar?'),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('Batal'),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(); // Tutup dialog
                                    },
                                  ),
                                  TextButton(
                                    child: Text('Logout'),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(); // Tutup dialog
                                      logout(); // Panggil fungsi logout()
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavItemTapped,
        selectedItemColor: Colors.redAccent,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Kategori',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

Widget customListTile({
  required IconData icon,
  required String text,
  Function()? onTap,
}) {
  return FractionallySizedBox(
    widthFactor: .9, // Mengatur faktor lebar menjadi setengah dari parent
    child: ListTile(
      leading: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: const Color.fromARGB(255, 173, 173, 173).withOpacity(0.1),
        ),
        child: Icon(icon, size: 24, color: Colors.black),
      ),
      title: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 15,
        ),
      ),
      trailing: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: const Color.fromARGB(255, 173, 173, 173).withOpacity(0.1),
        ),
        child: const Icon(
          Icons.keyboard_arrow_right,
          size: 26,
          color: Colors.black,
        ),
      ),
      onTap: onTap,
    ),
  );
}
