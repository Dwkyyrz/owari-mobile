// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:owari/menu/detail_product.dart';
import 'package:owari/menu/new_product.dart';
import 'package:owari/menu/new_design.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:owari/menu/profile/tentang.dart';
import 'dart:convert';

class Kategori extends StatefulWidget {
  @override
  _KategoriState createState() => _KategoriState();
}

class _KategoriState extends State<Kategori> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isDrawerOpen = false;

  List<dynamic> produkList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http
        .get(Uri.parse("http://localhost/owari/api/produk.php"));

    if (response.statusCode == 200) {
      setState(() {
        produkList = jsonDecode(response.body);
      });
    }
  }

  void _toggleDrawer() {
    setState(() {
      _isDrawerOpen = !_isDrawerOpen;
    });
    if (_isDrawerOpen) {
      _scaffoldKey.currentState?.openDrawer();
    } else {
      _scaffoldKey.currentState?.openEndDrawer();
    }
  }

  void _closeDrawer() {
    setState(() {
      _isDrawerOpen = false;
    });
    Navigator.of(context).pop();
  }

  // void navigateToDetailProduct() {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => DetailProductPage()),
  //   );
  // }

  void navigateToNewDesignPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => newDesign()),
    );
  }

  void navigateToNewProductPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => newProduct()),
    );
  }

  int _selectedIndex = 1;

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

  void goToLoginPage() {
    Navigator.popAndPushNamed(context, '/login');
  }

  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
    await prefs.remove('isLoggedIn');
    goToLoginPage();
  }

  void profile() {
    Navigator.popAndPushNamed(context, '/userProfile');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        icon: Icon(Icons.menu), onPressed: _toggleDrawer),
                    Image.asset('assets/logo.png', width: 100, height: 80),
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        // Kode aksi saat tombol pencarian ditekan
                        // Tambahkan logika sesuai kebutuhan Anda
                      },
                    ),
                  ],
                ),
              ),
              // Container(
              //   padding: EdgeInsets.all(16),
              //   alignment: Alignment.center,
              //   child:
              // ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: navigateToNewDesignPage,
                    child: Stack(
                      children: [
                        Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/1.png'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        Container(
                          width: 140,
                          height: 140,
                          alignment: Alignment.center,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            alignment: Alignment.bottomRight,
                            child: Text(
                              'OWARI',
                              style: TextStyle(
                                  fontSize: 38,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white.withOpacity(0.8)),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                        Container(
                          width: 140,
                          height: 140,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          // Pengaturan opasitas di sini
                          child: Container(
                            padding: EdgeInsets.all(20),
                            alignment: Alignment.topLeft,
                            child: Text(
                              'New Design',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                      onTap: navigateToNewProductPage,
                      child: Stack(
                        children: [
                          Container(
                            width: 140,
                            height: 140,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/6.png'),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          Container(
                            width: 140,
                            height: 140,
                            alignment: Alignment.center,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              alignment: Alignment.bottomRight,
                              child: Text(
                                'OWARI',
                                style: TextStyle(
                                    fontSize: 38,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                          Container(
                            width: 140,
                            height: 140,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 105, 0, 0)
                                  .withOpacity(0.8),
                              borderRadius: BorderRadius.circular(10),
                            ), // Pengaturan opasitas di sini
                            child: Container(
                              padding: EdgeInsets.all(20),
                              alignment: Alignment.topLeft,
                              child: Text(
                                'New Product',
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          )
                        ],
                      ))
                ],
              ),

              // ),
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
        drawer: SafeArea(
            child: GestureDetector(
          onTap: _closeDrawer,
          child: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 0, 0, 0).withOpacity(1),
                    ),
                    child: Padding(
                        padding: EdgeInsetsDirectional.all(0),
                        child: Image.asset(
                          'assets/logo.png',
                          color: Colors.white,
                        ))),
                ListTile(
                  title: Text('Profile'),
                  leading: Icon(
                    Icons.people,
                    color: Colors.black,
                  ),
                  onTap: () {
                    _closeDrawer();
                    profile();
                  },
                ),
                ListTile(
                  title: Text('Cari Produk'),
                  leading: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  onTap: () => logout(),
                ),
                ListTile(
                  title: Text('Kategori'),
                  leading: Icon(
                    Icons.category,
                    color: Colors.black,
                  ),
                  onTap: () => logout(),
                ),
                Expanded(
                  child: ListTile(
                    title: Text('LOGOUT'),
                    leading: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Konfirmasi Logout'),
                            content: Text('Apakah Anda yakin ingin logout?'),
                            actions: <Widget>[
                              TextButton(
                                child: Text('Batal'),
                                onPressed: () {
                                  Navigator.of(context).pop(); // Tutup dialog
                                },
                              ),
                              TextButton(
                                child: Text('Logout'),
                                onPressed: () {
                                  Navigator.of(context).pop(); // Tutup dialog
                                  logout(); // Panggil fungsi logout()
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        )));
  }
}
