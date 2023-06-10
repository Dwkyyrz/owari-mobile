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
    goToLoginPage();
  }

  int _selectedIndex = 2;
  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      Navigator.popAndPushNamed(context, '/home');
    } else if (index == 1) {
      Navigator.popAndPushNamed(context, '/kategori');
    } else if (index == 2) {
      Navigator.popAndPushNamed(context, '/userProfile');
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
                  color: Colors.yellow.withOpacity(0.4),
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
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      '${user!.email}',
                      style: const TextStyle(
                        fontSize: 15,
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
                    onTap: () => null,
                  ),
                  const SizedBox(height: 10),
                  customListTile(
                    icon: Icons.history,
                    text: "Riwayat Pembelian",
                    onTap: () => null,
                  ),
                  const SizedBox(height: 10),
                  customListTile(
                    icon: Icons.favorite_border_outlined,
                    text: "Wishlist",
                    onTap: () => null,
                  ),
                  const SizedBox(height: 10),
                  customListTile(
                    icon: Icons.privacy_tip_outlined,
                    text: "Kebijakan dan Privacy",
                    onTap: () => null,
                  ),
                  const SizedBox(height: 10),
                  customListTile(
                    icon: Icons.info_outline,
                    text: "About Owari",
                    onTap: () => null,
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: customListTile(
                        icon: Icons.logout,
                        text: "Logout",
                        onTap: () => logout(),
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
        selectedItemColor: Colors.yellow.withOpacity(1),
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
          color: Colors.yellow.withOpacity(0.1),
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
          color: Colors.black.withOpacity(0.1),
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
























//       child: Expanded(
//         child: Column(
//           children: [
//             Container(
//               height: 200,
//               color: Colors.blue,
//               child: Center(
//                 child: CircleAvatar(
//                   radius: 50,
//                   backgroundImage: AssetImage('assets/profile_picture.jpg'),
//                 ),
//               ),
//             ),
//             SizedBox(height: 16),
//             Text(
//               '${user!.name}',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 8),
//             Text(
//               '${user!.email}',
//               style: TextStyle(fontSize: 16),
//             ),
//             SizedBox(height: 16),
//             SingleChildScrollView(
//               child: Column(
//                 children: [
//                   ListTile(
//                     leading: Icon(Icons.person),
//                     title: Text('Personal Information'),
//                     trailing: Icon(Icons.arrow_forward_ios),
//                     onTap: () {
//                       // Tambahkan navigasi ke halaman informasi pribadi
//                     },
//                   ),
//                   ListTile(
//                     leading: Icon(Icons.payment),
//                     title: Text('Payment Methods'),
//                     trailing: Icon(Icons.arrow_forward_ios),
//                     onTap: () {
//                       // Tambahkan navigasi ke halaman metode pembayaran
//                     },
//                   ),
//                   ListTile(
//                     leading: Icon(Icons.settings),
//                     title: Text('Settings'),
//                     trailing: Icon(Icons.arrow_forward_ios),
//                     onTap: () {
//                       // Tambahkan navigasi ke halaman pengaturan
//                     },
//                   ),
//                   ListTile(
//                     leading: Icon(Icons.help),
//                     title: Text('Help & Support'),
//                     trailing: Icon(Icons.arrow_forward_ios),
//                     onTap: () {
//                       // Tambahkan navigasi ke halaman bantuan dan dukungan
//                     },
//                   ),
//                 ],
//               ),
//             ),
//             BottomNavigationBar(
//               currentIndex: _selectedIndex,
//               onTap: _onNavItemTapped,
//               items: [
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.home),
//                   label: 'Home',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.category),
//                   label: 'Kategori',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.person),
//                   label: 'Profile',
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     ));
//   }
// }

// Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('ID User: ${user!.id}'),
//             Text('Name: ${user!.name}'),
//             Text('Email: ${user!.email}'),
//             Text('Phone Number: ${user!.phoneNumber}'),
//             Text('Address: ${user!.address}'),
//             ElevatedButton(
//               onPressed: () {
//                 logout();
//               },
//               child: Text('Logout'),
//             ),
//           ],
//         ),
//       ),