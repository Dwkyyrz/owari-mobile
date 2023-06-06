import 'package:flutter/material.dart';

class TambahProduk extends StatelessWidget {

  final TextEditingController _nama = new TextEditingController();
  final TextEditingController _deskripsi = new TextEditingController();
  final TextEditingController _stock = new TextEditingController();
  final TextEditingController _harga = new TextEditingController();
  final TextEditingController _ukuran = new TextEditingController();
  final TextEditingController _foto = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.8),
            child: TextField(
              controller: _nama,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Masukkan Nama'
              ),
            ),
            ),
          Padding(
            padding: const EdgeInsets.all(8.8),
            child: TextField(
              controller: _deskripsi,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Masukkan Deskripsi'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.8),
            child: TextField(
              controller: _stock,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Masukkan Stok'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.8),
            child: TextField(
              controller: _harga,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Masukkan Harga'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.8),
            child: TextField(
              controller: _ukuran,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Masukkan Ukuran'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.8),
            child: TextField(
              controller: _foto,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Masukkan Foto'),
            ),
          ),
          SizedBox(height: 20,),
          ElevatedButton(onPressed: (){

          }, child: Text('goto')
          )
        ],
      ),
    );
  }
}
