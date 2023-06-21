// ignore_for_file: unused_import, unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:owari/menu/category.dart';
import 'package:owari/menu/detail_product.dart';
import 'package:owari/menu/new_product.dart';
import 'package:owari/menu/new_design.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:owari/menu/profile/tentang.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
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

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isDrawerOpen = false;

  List<dynamic> produkList = [];
  User? user;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response =
        await http.get(Uri.parse("http://10.0.2.2/owari/api/produk.php"));

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

  int _selectedIndex = 0;

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
    Navigator.pushNamed(context, '/userProfile');
  }

  void category() {
    Navigator.pushNamed(context, '/kategori');
  }

  void cariProduk() {
    Navigator.pushNamed(context, '/userProfile');
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

              Expanded(
                child: RefreshIndicator(
                  onRefresh: fetchData,
                  child: GridView.builder(
                    itemCount: produkList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.height * 0.5),
                    ),
                    itemBuilder: (context, index) {
                      var produk = produkList[index];
                      var fotoURL =
                          "http://localhost/owari/img/${produk['foto']}";
                      var p_id = produk['p_id'];
                      var category = produk['category'];
                      var nama = produk['nama'];
                      var deskripsi = produk['deskripsi'];
                      var stock = produk['stock'];
                      var harga = int.parse(produk['harga']);
                      var ukuran = produk['ukuran'];
                      var foto = produk['foto'];
                      var created_at = produk['created_at'];
                      var update_at = produk['update_at'];
                      return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailProductPage(
                                  product: produk,
                                  // user_id: user!.id.toString(),
                                ),
                              ),
                            );
                          },
                          child: Card(
                            margin: EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  fotoURL,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: 300,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        nama,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        deskripsi,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        NumberFormat.currency(
                                                locale: 'id',
                                                symbol: 'Rp ',
                                                decimalDigits: 0)
                                            .format(harga),
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ));
                    },
                  ),
                ),
              ) // ),
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
                  onTap: () => cariProduk(),
                ),
                ListTile(
                  title: Text('Kategori'),
                  leading: Icon(
                    Icons.category,
                    color: Colors.black,
                  ),
                  onTap: () => category(),
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
