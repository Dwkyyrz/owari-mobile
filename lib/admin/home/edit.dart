import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:owari/admin/dashboard/dashboard.dart';
import '/admin/mainleo.dart';

class EditData extends StatefulWidget {
  final Map ListData;
  EditData({Key? key, required this.ListData}) : super(key: key);

  @override
  State<EditData> createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController _nama;
  late TextEditingController _category;
  late TextEditingController _stock;
  late TextEditingController _harga;
  late TextEditingController _deskripsi;
  late TextEditingController _ukuran;
  late TextEditingController _foto;

  Future<bool> _update() async {
    try {
      final response = await http.post(
        Uri.parse('https://owari-1.000webhostapp.com/api/update_produk.php'),
        body: {
          'nama': _nama.text,
          'category': _category.text,
          'deskripsi': _deskripsi.text,
          'stock': _stock.text,
          'harga': _harga.text,
          'ukuran': _ukuran.text,
          'foto': _foto.text
        },
      );
      if (response.statusCode == 200) {
        // Produk berhasil diupdate
        return true;
      } else {
        // Gagal update produk
        return false;
      }
    } catch (e) {
      // Terjadi error dalam koneksi atau permintaan HTTP
      print(e);
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    _nama = TextEditingController(text: widget.ListData['nama']);
    _category = TextEditingController(text: widget.ListData['category']);
    _stock = TextEditingController(text: widget.ListData['stock'].toString());
    _harga = TextEditingController(text: widget.ListData['harga'].toString());
    _deskripsi = TextEditingController(text: widget.ListData['deskripsi']);
    _ukuran = TextEditingController(text: widget.ListData['ukuran']);
    _foto = TextEditingController(text: widget.ListData['foto']);
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
                    borderSide: BorderSide(color: Colors.black),
                  ),
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
              SizedBox(height: 3),
              TextFormField(
                controller: _category,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  hintText: "Kategori Produk",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Colors.black),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Kategori produk tidak boleh kosong";
                  }
                  return null;
                },
              ),
              SizedBox(height: 3),
              TextFormField(
                controller: _deskripsi,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
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
              SizedBox(height: 3),
              TextFormField(
                controller: _stock,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
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
              SizedBox(height: 3),
              TextFormField(
                controller: _harga,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
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
              SizedBox(height: 3),
              TextFormField(
                controller: _ukuran,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
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
              SizedBox(height: 3),
              TextFormField(
                controller: _foto,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
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
              SizedBox(height: 3),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                ),
                child: Text("Update"),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    try {
                      _update().then((value) {
                        if (value) {
                          scaffoldMessangerKey.currentState!.showSnackBar(
                              SnackBar(
                                  content: Text("Data Berhasil Diupdate")));
                        } else {
                          scaffoldMessangerKey.currentState!.showSnackBar(
                              SnackBar(content: Text("Data Gagal Diupdate")));
                        }
                      });
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: ((BuildContext context) => Dashboard())),
                          (route) => false);
                    } catch (e) {
                      print('Error $e');
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
