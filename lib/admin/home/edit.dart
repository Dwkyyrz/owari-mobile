import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:owari/admin/dashboard/dashboard.dart';

class EditData extends StatefulWidget {
  final Map ListData;
  final String foto;

  const EditData({required this.ListData, required this.foto});

  @override
  State<EditData> createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController id = TextEditingController();
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
    id.text = widget.ListData['p_id'].toString();
    _nama.text = widget.ListData['nama'];
    _category.text = widget.ListData['category'];
    _deskripsi.text = widget.ListData['deskripsi'];
    _stock.text = widget.ListData['stock'].toString();
    _harga.text = widget.ListData['harga'].toString();
    _ukuran.text = widget.ListData['ukuran'];
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

Future<bool> _update() async {
    try {
      final url =
          Uri.parse('https://owarishop.000webhostapp.com/update_produk.php');

      var request = http.MultipartRequest('POST', url);
      request.fields['p_id'] = id.text;
      request.fields['nama'] = _nama.text;
      request.fields['category'] = _category.text;
      request.fields['deskripsi'] = _deskripsi.text;
      request.fields['stock'] = _stock.text;
      request.fields['harga'] = _harga.text;
      request.fields['ukuran'] = _ukuran.text;

      // Add foto if it's changed
      if (_isFotoChanged && _foto != null) {
        request.files
            .add(await http.MultipartFile.fromPath('foto', _foto!.path));
      }

      final response = await request.send();

      if (response.statusCode == 200) {
        // Produk berhasil diupdate

        // Menangani respons dari server
        String responseString = await response.stream.bytesToString();
        print(
            responseString); // Cetak respons dari server untuk pemecahan masalah

        // Lakukan penanganan respons sesuai dengan kebutuhan aplikasi Anda
        // Contoh: Jika respons berisi kata "sukses", maka kembalikan true
        if (responseString.contains("sukses")) {
          return true;
        } else {
          return false;
        }
      } else {
        // Gagal mengupdate produk
        print('Update failed: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      // Terjadi error dalam koneksi atau permintaan HTTP
      print('Error: $e');
      return false;
    }
  }


  Widget _buildProductImage() {
    try {
      return _foto != null
          ? Image.file(File(_foto!.path))
          : Image.network(
              "https://owarishop.000webhostapp.com/img/${widget.foto}",
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return CircularProgressIndicator();
              },
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                print('Error loading image: $exception');
                return Container(); // Tampilkan placeholder atau widget lain sebagai pengganti gambar yang gagal dimuat.
              },
            );
    } catch (e) {
      print('Error loading image: $e');
      return Container(); // Tampilkan placeholder atau widget lain sebagai pengganti gambar yang gagal dimuat.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text("Edit Produk"),
      ),
      body: SingleChildScrollView(
        child: Form(
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
                SizedBox(height: 10),
                _buildProductImage(),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white
                  ),
                  onPressed: _uploadFoto,
                  child: Text("Pilih Foto"),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white
                  ),
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      bool success = await _update();
                      if (success) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Berhasil'),
                              content: Text('Produk berhasil diupdate.'),
                              actions: <Widget>[
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black,
                                    foregroundColor: Colors.white
                                  ),
                                  child: Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (_) => Dashboard()),
                                      (Route<dynamic> route) => false,
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Berhasil'),
                              content: Text(
                                  'Refresh Produk'),
                              actions: <Widget>[
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black,
                                    foregroundColor: Colors.white
                                  ),
                                  child: Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (_) => Dashboard()),
                                      (Route<dynamic> route) => false,
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    }
                  },
                  child: Text("Update"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
