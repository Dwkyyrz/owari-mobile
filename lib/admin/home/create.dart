import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:owari/admin/dashboard/dashboard.dart';
import 'package:owari/admin/mainleo.dart';
import 'package:image_picker/image_picker.dart';

class TambahProduk extends StatefulWidget {
  TambahProduk({Key? key}) : super(key: key);

  @override
  State<TambahProduk> createState() => _TambahProdukState();
}

class _TambahProdukState extends State<TambahProduk> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _nama = TextEditingController();
  final TextEditingController _category = TextEditingController();
  final TextEditingController _deskripsi = TextEditingController();
  final TextEditingController _stock = TextEditingController();
  final TextEditingController _harga = TextEditingController();
  final TextEditingController _ukuran = TextEditingController();
  XFile? _foto;

  Future<void> _uploadFoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _foto = XFile(pickedFile.path);
      });
    }
  }

  Future<bool> _simpan() async {
    if (_foto == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Harap pilih foto produk")),
      );
      return false;
    }

    final url = Uri.parse('https://owari-1.000webhostapp.com/api/test.php');

    try {
      var request = http.MultipartRequest('POST', url);
      request.fields['nama'] = _nama.text;
      request.fields['category'] = _category.text;
      request.fields['deskripsi'] = _deskripsi.text;
      request.fields['stock'] = _stock.text;
      request.fields['harga'] = _harga.text;
      request.fields['ukuran'] = _ukuran.text;

      request.files.add(await http.MultipartFile.fromPath('foto', _foto!.path));

      final response = await request.send();

      if (response.statusCode == 200) {
        // Produk berhasil ditambahkan
        return true;
      } else {
        // Gagal menambahkan produk
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
        title: Text("Tambah Produk"),
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
                          scaffoldMessengerKey.currentState!.showSnackBar(
                              SnackBar(
                                  content: Text("Data Berhasil Disimpan")));
                        } else {
                          scaffoldMessengerKey.currentState!.showSnackBar(
                              SnackBar(content: Text("Data Gagal Disimpan")));
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
