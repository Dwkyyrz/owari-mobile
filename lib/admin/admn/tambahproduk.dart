import 'package:owari/admin/admn/inputdata.dart';
import 'package:owari/admin/model/network_request.dart';
import 'package:owari/admin/model/product.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TambahProduk extends StatefulWidget {
  @override
  State<TambahProduk> createState() => _TambahProdukState();
}

class _TambahProdukState extends State<TambahProduk> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nama = TextEditingController();
  final TextEditingController _deskripsi = TextEditingController();
  final TextEditingController _stock = TextEditingController();
  final TextEditingController _harga = TextEditingController();
  final TextEditingController _ukuran = TextEditingController();
  final TextEditingController _foto = TextEditingController();

  Future<void> addData(Product produk) async {
    await NetworkRequest().addData(produk).then((success) => {
          Fluttertoast.showToast(msg: "Data submitted"),
          Navigator.pop(context)
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(height: 30.0),
          Center(
            child: Text(
              "Tambah Data",
              style: TextStyle(fontSize: 30.0),
            ),
          ),
          SizedBox(height: 30.0),
          Form(
            key: _formKey,
            child: Column(children: [
              InputData(
                  hintedtext: "Nama Produk",
                  labledtext: "Nama",
                  Inputcontroller: _nama),
              SizedBox(height: 10.0),
              InputData(
                  hintedtext: "Deskripsi Produk",
                  labledtext: "Deskripsi",
                  Inputcontroller: _deskripsi),
              SizedBox(height: 10.0),
              InputData(
                  hintedtext: "Stock Produk",
                  labledtext: "Stock",
                  Inputcontroller: _stock),
              SizedBox(height: 10.0),
              InputData(
                  hintedtext: "Harga Produk",
                  labledtext: "Harga",
                  Inputcontroller: _harga),
              SizedBox(height: 10.0),
              InputData(
                  hintedtext: "Ukuran Produk",
                  labledtext: "Ukuran",
                  Inputcontroller: _ukuran),
              SizedBox(height: 10.0),
              InputData(
                  hintedtext: "Foto Produk",
                  labledtext: "Foto",
                  Inputcontroller: _foto),
              SizedBox(height: 10.0)
            ]),
          ),
          SizedBox(
            height: 10.0,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(300.0, 60), elevation: 20.0),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Product produk = Product(
                      nama: _nama.text,
                      deskripsi: _deskripsi.text,
                      stock: int.tryParse(_stock.text),
                      harga: _harga.text,
                      ukuran: _ukuran.text,
                      foto: _foto.text);
                  addData(produk);
                  _nama.clear();
                  _deskripsi.clear();
                  _stock.clear();
                  _harga.clear();
                  _ukuran.clear();
                  _foto.clear();
                }
              },
              child: Text("Submit"))
        ]),
      ),
    );
  }
}
