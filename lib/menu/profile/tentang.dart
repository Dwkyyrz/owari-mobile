import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AboutOwari extends StatefulWidget {
  @override
  _AboutOwariState createState() => _AboutOwariState();
}

class _AboutOwariState extends State<AboutOwari> {
  List<dynamic> produkList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http
        .get(Uri.parse("https://owarishop.000webhostapp.com/api/produk.php"));

    if (response.statusCode == 200) {
      setState(() {
        produkList = jsonDecode(response.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Owari"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0), // Tambahkan padding di sini
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage('assets/logo.png'),
                backgroundColor: Colors.white,
              ),
              SizedBox(height: 20),
              Text(
                "Owari merupakan salah satu bisnis yang berbidang pada penjualan barang seperti baju, tumbler, dan totbag. "
                "Namun, Owari saat ini mengalami kendala dalam melakukan pemasaran dan branding pada brand mereka sendiri. "
                "Terbatasnya penyebaran informasi tentang produk mereka ke masyarakat luas menjadi tantangan utama yang dihadapi.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
