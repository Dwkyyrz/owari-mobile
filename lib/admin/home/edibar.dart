import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:owari/admin/dashboard/dashboard.dart';
import 'package:owari/admin/mainleo.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProduk extends StatefulWidget {
  UpdateProduk({Key? key}) : super(key: key);

  @override
  State<UpdateProduk> createState() => _UpdateProdukState();
}

class _UpdateProdukState extends State<UpdateProduk> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _nama = TextEditingController();
  final TextEditingController _category = TextEditingController();
  final TextEditingController _deskripsi = TextEditingController();
  final TextEditingController _stock = TextEditingController();
  final TextEditingController _harga = TextEditingController();
  final TextEditingController _ukuran = TextEditingController();
  XFile? _foto;
  bool _isFotoChanged = false;

  @override
  void initState() {
    super.initState();

    // Set initial values for the controllers
    _nama.text = "Nama Produk"; // Set the initial value for nama
    _category.text = "Kategori Produk"; // Set the initial value for category
    _deskripsi.text = "Deskripsi Produk"; // Set the initial value for deskripsi
    _stock.text = "Stock Produk"; // Set the initial value for stock
    _harga.text = "Harga Produk"; // Set the initial value for harga
    _ukuran.text = "Ukuran Produk"; // Set the initial value for ukuran
    // Load existing foto if available
    //  // Uncomment this line and replace "path_to_existing_foto" with the actual path
  }

  Future<void> _uploadFoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _foto = XFile(pickedFile.path);
        _isFotoChanged = true;
      });
    }
  }

  Future<bool> _simpan() async {
    // Check if foto is changed or not
    if (_isFotoChanged && _foto == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Harap pilih foto produk")),
      );
      return false;
    }

    final url = Uri.parse('https://owarishop.000webhostapp.com/test.php');

    try {
      var request = http.MultipartRequest('POST', url);
      request.fields['nama'] = _nama.text;
      request.fields['category'] = _category.text;
      request.fields['deskripsi'] = _deskripsi.text;
      request.fields['stock'] = _stock.text;
      request.fields['harga'] = _harga.text;
      request.fields['ukuran'] = _ukuran.text;

      // Add foto if it's changed
      if (_isFotoChanged) {
        request.files
            .add(await http.MultipartFile.fromPath('foto', _foto!.path));
      }

      final response = await request.send();

      if (response.statusCode == 200) {
        // Produk berhasil diupdate
        return true;
      } else {
        // Gagal mengupdate produk
        return false;
      }
    } catch (e) {
      // Terjadi error dalam koneksi atau permintaan HTTP
      print(e);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text("Update Produk"),
      ),
      body: Form(
        key: formKey,
        child: Container(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
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
                SizedBox(height: 3),
                TextFormField(
                  controller: _category,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
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
                SizedBox(height: 3),
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
                SizedBox(height: 3),
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
                SizedBox(height: 3),
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
                SizedBox(height: 3),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                  ),
                  child: Text("Pilih Foto"),
                  onPressed: _uploadFoto,
                ),
                SizedBox(height: 3),
                _foto != null ? Image.file(File(_foto!.path)) : Placeholder(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                  ),
                  child: Text("Simpan"),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      try {
                        _simpan().then((value) {
                          if (value) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Data Berhasil Diupdate")));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Data Gagal Diupdate")));
                          }
                        });
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: ((BuildContext context) =>
                                    Dashboard())),
                            (route) => false);
                      } catch (e) {
                        print('Error $e');
                      }
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
