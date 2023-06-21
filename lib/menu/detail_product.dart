// ignore_for_file: unused_import, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
// import 'package:flutter_share/flutter_share.dart';
import 'package:http/http.dart' as http;

class DetailProductPage extends StatelessWidget {
  final dynamic product;

  DetailProductPage({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            10), // Atur nilai radius sesuai keinginan Anda
                        child: Image.network(
                          "https://localhost/owari/img/${product['foto']}",
                          width: double.infinity,
                          fit: BoxFit.cover,
                          height: 300,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              NumberFormat.currency(
                                locale: 'id',
                                symbol: 'Rp ',
                                decimalDigits: 0,
                              ).format(int.parse(product['harga'])),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          SizedBox(height: 4),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '${product['nama'].toUpperCase()}',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          SizedBox(height: 4),
                          Divider(
                            color: Colors.grey,
                            thickness: 1.0,
                            height: 20.0,
                          ),
                          Column(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Detail Produk",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                  alignment: Alignment.centerLeft,
                                  child:
                                      Text('Kategori: ${product['category']}')),
                              Divider(
                                color: Colors.grey,
                                thickness: 0.5,
                                height: 10.0,
                              ),
                              SizedBox(height: 4),
                              Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text('Stock: ${product['stock']}')),
                              Divider(
                                color: Colors.grey,
                                thickness: 0.5,
                                height: 10.0,
                              ),
                              SizedBox(height: 4),
                              Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text('Ukuran: ${product['ukuran']}')),
                              Divider(
                                color: Colors.grey,
                                thickness: 0.5,
                                height: 10.0,
                              ),
                              SizedBox(height: 4),
                              Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                      'Deskripsi: ${product['deskripsi']}')),
                              Divider(
                                color: Colors.grey,
                                thickness: 0.5,
                                height: 10.0,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 56.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.chat),
                    color: Colors.grey,
                    onPressed: () {
                      openwhatsapp(context);
                    },
                  ),
                  Text("Hubungi Admin"),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.shopping_cart),
                    color: Colors.green,
                    onPressed: () {
                      order(context);
                    },
                  ),
                  Text("Pesan",
                      style: TextStyle(
                        color: Colors.green,
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void openwhatsapp(BuildContext context) async {
    String whatsapp = "6289616603042";
    // String pesanText = "Hello";

    String message = 'Halo, saya ingin bertanya produk ini:';
    message += '\nNama: ${product['nama']}';
    message += '\nHarga: ${product['harga']}';
    message += '\nKategori: ${product['category']}';
    message += '\nUkuran: ${product['ukuran']}';

    String whatsappURlAndroid = "https://wa.me/ $whatsapp?text=$message";

    var whatappURLIos = "https://wa.me/$whatsapp?text=$message";

    if (Platform.isIOS) {
      // untuk ios
      if (await canLaunch(whatappURLIos)) {
        await launch(whatappURLIos, forceSafariVC: false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("whatsapp no installed")));
      }
    } else {
      // android , web
      if (await canLaunch(whatsappURlAndroid)) {
        await launch(whatsappURlAndroid);
      } else {
        var context2 = context;
        ScaffoldMessenger.of(context2).showSnackBar(
            const SnackBar(content: Text("whatsapp tidak terinstall")));
      }
    }
  }

  void order(BuildContext context) async {
    String whatsapp = "6289616603042";
    // String pesanText = "Hello";

    String message =
        'Selamat datang Di Owari \nHalo Admin Owari :)\n saya ingin memesan produk ini:';
    message += '\n Nama: ${product['nama']}';
    message += '\nHarga: ${product['harga']}';
    message += '\nKategori: ${product['category']}';
    message += '\nUkuran: ${product['ukuran']}';

    String whatsappURlAndroid = "https://wa.me/ $whatsapp?text=$message";

    var whatappURLIos = "https://wa.me/$whatsapp?text=$message";

    if (Platform.isIOS) {
      // untuk ios
      if (await canLaunch(whatappURLIos)) {
        await launch(whatappURLIos, forceSafariVC: false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("whatsapp no installed")));
      }
    } else {
      // android , web
      if (await canLaunch(whatsappURlAndroid)) {
        await launch(whatsappURlAndroid);
      } else {
        var context2 = context;
        ScaffoldMessenger.of(context2).showSnackBar(
            const SnackBar(content: Text("whatsapp no installed ")));
      }
    }
  }
}
