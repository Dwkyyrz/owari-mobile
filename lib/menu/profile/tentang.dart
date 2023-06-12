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
      appBar: AppBar(
        title: Text('About Owari'),
      ),
      body: GridView.builder(
        itemCount: produkList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height * 0.5),
        ),
        itemBuilder: (context, index) {
          var produk = produkList[index];
          var fotoURL =
              "https://owarishop.000webhostapp.com/img/${produk['foto']}";
          var title = produk['nama'];
          var description = produk['deskripsi'];
          var price = produk['harga'];

          return InkWell(
            onTap: () => null,
            child: Card(
            margin: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  fotoURL,
                  fit: BoxFit.fill,
                  width: double.infinity,
                  height: 300,
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        price,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ));
        },
      ),
    );
  }
}
