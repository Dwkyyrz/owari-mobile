import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:owari/admin/dashboard/dashboard.dart';

import '../mainleo.dart';

class EditData extends StatefulWidget {
  final Map ListData;
  EditData({Key? key, required this.ListData}) : super(key: key);

  @override
  State<EditData> createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _pid = TextEditingController();
  final TextEditingController _catid = TextEditingController();
  final TextEditingController _nama = TextEditingController();
  final TextEditingController _deskripsi = TextEditingController();
  final TextEditingController _stock = TextEditingController();
  final TextEditingController _harga = TextEditingController();
  final TextEditingController _ukuran = TextEditingController();
  final TextEditingController _foto = TextEditingController();

  Future<bool> _update() async {
    final response = await http.post(
        Uri.parse('https://owari-1.000webhostapp.com/owari/update_produk.php'),
        body: {
          "p_id" : _pid.text,
          "cat_id": _catid.text,
          "nama": _nama.text,
          "deskripsi": _deskripsi.text,
          "stock": _stock.text,
          "harga": _harga.text,
          "ukuran": _ukuran.text,
          "foto": _foto.text
        });
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  void initState() {
    super.initState();
    _nama.text = widget.ListData['nama'];
    _deskripsi.text = widget.ListData['deskripsi'];
    _stock.text = widget.ListData['stock'].toString();
    _harga.text = widget.ListData['harga'].toString();
    _ukuran.text = widget.ListData['ukuran'];
    _foto.text = widget.ListData['foto'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text("Edit Produk"),
      ),
      body: Form(
        key: formKey,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              TextFormField(
                controller: _nama,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  hintText: "Nama Produk",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Colors.black),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Nama produk tidak boleh kosong";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _deskripsi,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  hintText: "Deskripsi Produk",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Colors.black),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Deskripsi produk tidak boleh kosong";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _stock,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  hintText: "Stock Produk",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Colors.black),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Stock produk tidak boleh kosong";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _harga,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  hintText: "Harga Produk",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Colors.black),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Harga produk tidak boleh kosong";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _ukuran,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  hintText: "Ukuran Produk",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Colors.black),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Ukuran produk tidak boleh kosong";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _foto,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  hintText: "Foto Produk",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Colors.black),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Foto produk tidak boleh kosong";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white),
                child: Text("Update"),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    _update().then((value) {
                      if (value) {
                        scaffoldMessangerKey.currentState!.showSnackBar(
                            SnackBar(content: Text("Data Berhasil Di Update")));
                      } else {
                        scaffoldMessangerKey.currentState!.showSnackBar(
                            SnackBar(content: Text("Data Gagal Di Update")));
                      }
                    });
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: ((BuildContext context) => Dashboard())),
                        (route) => false);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
