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
      appBar:AppBar(

      ) ,
      body: SafeArea(
        
        child: Container(
          // alignment: Alignment.centerLeft,
          child: Text(
            '"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
