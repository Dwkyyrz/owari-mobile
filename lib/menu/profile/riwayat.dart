import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:owari/menu/profile/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:owari/menu/model/Model.dart';

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

class RiwayatPembelian extends StatefulWidget {
  const RiwayatPembelian({Key? key}) : super(key: key);

  @override
  _RiwayatPembelianState createState() => _RiwayatPembelianState();
}

class _RiwayatPembelianState extends State<RiwayatPembelian> {
  User? user;
  List<int> quantities = [];
  List<Model>? snapshotData; // Variable to store fetched data
  bool orderPlaced = false;
  bool isOrderPlaced = false; // Flag to track if order is already placed

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

  void deleteData(int id) async {
    final response = await http.get(
      Uri.parse('https://owari2.000webhostapp.com/owari/api/hapus-keranjang.php?id=$id'),
    );

    try {
        if (response.statusCode == 200) {
        // Jika permintaan berhasil
        var data = jsonDecode(response.body);
        String status   = data['status'];
        String message  = data['message'];

        if (status == 'success') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message)),
          );

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => UserProfile()),
          );

        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Terjadi kesalahan: $message')),
          );
        }
      } else {
        // Jika permintaan gagal
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Terjadi kesalahan saat menghubungi server')),
        );
      }

  } catch (e) {
    print(e);
  }

    }

  Future<List<Model>?> fetchData(int id) async {
    final response = await http.get(
      Uri.parse('https://owari2.000webhostapp.com/owari/api/keranjang.php?id=$id'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      return responseData.map((data) => Model.fromJson(data)).toList();
    } else {
      // Handle error response
      return null;
    }
  }

  void goToLoginPage() {
    Navigator.popAndPushNamed(context, '/login');
  }

  void goToProfilePage() {
    Navigator.popAndPushNamed(context, '/userProfile');
  }

  void openWhatsApp(BuildContext context, List<Model> products) async {
  if (!isOrderPlaced && products.isNotEmpty) {
    String whatsapp = "6289616603042";
    String message = 'Halo, saya ingin bertanya produk ini:\n';

    for (int index = 0; index < products.length; index++) {
      final product = products[index];
      message += 'Produk ${index + 1}:\n';
      message += 'Nama: ${product.nama}\n';
      message += 'Harga: ${product.harga}\n';
      message += 'Kategori: ${product.category}\n';
      message += 'Ukuran: ${product.ukuran}\n';
      message += 'Jumlah: ${quantities[index]}\n\n';
    }

    String whatsappURlAndroid = "https://wa.me/$whatsapp?text=${Uri.encodeComponent(message)}";
    var whatappURLIos = "https://wa.me/$whatsapp?text=${Uri.encodeComponent(message)}";

      if (Platform.isIOS) {
        // untuk ios
        if (await canLaunch(whatappURLIos)) {
          await launch(whatappURLIos, forceSafariVC: false);
          deleteData(int.parse(user?.id ?? ''));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("WhatsApp tidak terinstall")),
          );
        }
      } else {
        // android , web
        if (await canLaunch(whatsappURlAndroid)) {
          await launch(whatsappURlAndroid);
          deleteData(int.parse(user?.id ?? ''));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("WhatsApp tidak terinstall")),
          );
        }
      }
    }
  }

  void order(BuildContext context, String productName, int productPrice, int quantity) async {
    if (orderPlaced) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Order has already been placed")),
      );
      return;
    }

    String whatsapp = "6289616603042";

    String message = 'Selamat datang Di Owari \nHalo Admin Owari :)\n saya ingin memesan produk ini:';
    message += '\n Nama: $productName';
    message += '\nHarga: $productPrice';
    message += '\nJumlah: $quantity';

    String whatsappURLAndroid = "https://wa.me/$whatsapp?text=$message";
    var whatsappURLIOS = "https://wa.me/$whatsapp?text=$message";

    if (Platform.isIOS) {
      // For iOS
      if (await canLaunch(whatsappURLIOS)) {
        await launch(whatsappURLIOS, forceSafariVC: false);
        setState(() {
          orderPlaced = true;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("WhatsApp is not installed")),
        );
      }
    } else {
      // For Android and web
      if (await canLaunch(whatsappURLAndroid)) {
        await launch(whatsappURLAndroid);
        setState(() {
          orderPlaced = true;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("WhatsApp is not installed")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang Saya'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Konfirmasi'),
                      content: const Text('Anda yakin ingin mengosongkan keranjang ini?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Menutup dialog
                          },
                          child: const Text('Batal'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Menutup dialog
                            deleteData(int.parse(user?.id ?? ''));
                          },
                          child: const Text('Hapus'),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: const Icon(Icons.delete),
            ),

        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  goToProfilePage();
                },
                child: Center(
                  child: 
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.grey,
                      backgroundImage: AssetImage('assets/banner2.png'),
                    ),
                  ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  '${user?.name ?? ''}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Center(
                child: Text(
                  '${user?.email ?? ''}',
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: 
                FutureBuilder<List<Model>?>(
                future: fetchData(int.parse(user?.id ?? '')),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.data == null) {
                    return const Text('No data available');
                  } else {
                    snapshotData = snapshot.data;

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshotData!.length,
                      itemBuilder: (context, index) {
                        final model = snapshotData![index];
                        quantities.add(1);

                        return Card(
                          child: ListTile(
                            title: Text('${model.nama ?? ''}'),
                            subtitle: Text(
                              'Harga: ${model.harga ?? ''}',
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: () {
                                    setState(() {
                                      if (quantities[index] > 1) {
                                        quantities[index]--;
                                      }
                                    });
                                  },
                                ),
                                Text(
                                  '${quantities[index]}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () {
                                    setState(() {
                                      quantities[index]++;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
              ),      
            
              const SizedBox(height: 20),
              Center(
                child: 
                ElevatedButton(
  onPressed: () {
    if (quantities.isNotEmpty && snapshotData != null) {
      openWhatsApp(context, snapshotData!);
    }
  },
  child: const Text(
    'Pesan',
    style: TextStyle(
      color: Colors.white,
    ),
  ),
  style: ElevatedButton.styleFrom(
    primary: Colors.green,
  ),
),
              )
            ],
          ),
        ),
      ),
    );
  }
}
