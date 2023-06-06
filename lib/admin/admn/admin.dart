import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:owari/admin/admn/tambahproduk.dart';

class Admin extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<Admin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => TambahProduk()));
            },
            child: Text("Ke halaman 2")),
      ),
    );
  }
}
