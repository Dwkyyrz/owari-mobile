import 'package:flutter/material.dart';

class InputData extends StatefulWidget {

  final String nama;
  final String deskripsi;
  final String stock;
  final String harga;
  final String ukuran;
  final String foto;

  InputData(
      {required this.nama,
      required this.deskripsi,
      required this.stock,
      required this.harga,
      required this.ukuran,
      required this.foto});

  @override
  _InputDataState createState() => _InputDataState();
}

class _InputDataState extends State<InputData> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Column(children: [
        // Text('Nama : ${nama}'),
        // Text('Deskripsi : ${deskripsi}'),
        // Text('Stock : ${stock}'),
        // Text('Harga : ${harga}'),
        // Text('Ukuran : ${ukuran}'),
        // Text('Foto : ${foto}')
    ],
    ),
    );
  }
}
