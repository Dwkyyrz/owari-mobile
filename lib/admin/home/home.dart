import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:owari/admin/dashboard/dashboard.dart';
import 'package:owari/admin/home/create.dart';
import 'package:owari/admin/home/edit.dart';
import 'package:owari/admin/mainleo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _listdata = [];
  bool _isLoading = true;

  void goToLoginPage() {
    Navigator.popAndPushNamed(context, '/login');
  }

  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
    await prefs.remove('isLoggedIn');
    goToLoginPage();
  }

  Future _getdata() async {
    try {
      final response = await http.get(
          Uri.parse('https://owari-1.000webhostapp.com/api/read_produk.php'));
      if (response.statusCode == 200) {
        // print(response.body);
        final data = jsonDecode(response.body);
        setState(() {
          _listdata = data;
          _isLoading = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future _hapus(String id) async {
    try {
      final response = await http.post(
          Uri.parse('https://owari-1.000webhostapp.com/api/del_produk.php'),
          body: {
            'p_id': id,
          });
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _getdata();
    print("Success");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              logout();
            },
            icon: Icon(Icons.arrow_back)),
        title: Text("Home Page"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: _getdata,
              child: ListView.separated(
                itemCount: _listdata.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => EditData(ListData: {
                                      "p_id": _listdata[index]['p_id'],
                                      "category": _listdata[index]['category'],
                                      "nama": _listdata[index]['nama'],
                                      "deskripsi": _listdata[index]
                                          ['deskripsi'],
                                      "stock": _listdata[index]['stock'],
                                      "harga": _listdata[index]['harga'],
                                      "ukuran": _listdata[index]['ukuran'],
                                      "foto": _listdata[index]['foto'],
                                    }))));
                      },
                      child: ListTile(
                        title: Text(_listdata[index]['nama']),
                        subtitle: Text(_listdata[index]['deskripsi']),
                        trailing: IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: ((context) {
                                    return AlertDialog(
                                      content: Text("Apakah anda yakin ?"),
                                      actions: [
                                        ElevatedButton(
                                            onPressed: () {
                                              _hapus(_listdata[index]['p_id']
                                                      .toString())
                                                  .then((value) {
                                                if (value) {
                                                  scaffoldMessengerKey
                                                      .currentState!
                                                      .showSnackBar(SnackBar(
                                                          content: Text(
                                                              "Data Berhasil Dihapus")));
                                                } else {
                                                  scaffoldMessengerKey
                                                      .currentState!
                                                      .showSnackBar(SnackBar(
                                                          content: Text(
                                                              "Data Gagal Dihapus")));
                                                }
                                              });
                                              Navigator.of(context)
                                                  .pushAndRemoveUntil(
                                                      MaterialPageRoute(
                                                          builder: ((BuildContext
                                                                  context) =>
                                                              Dashboard())),
                                                      (route) => false);
                                            },
                                            child: Text("Ya")),
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("Tidak"))
                                      ],
                                    );
                                  }));
                            },
                            icon: Icon(Icons.delete)),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => TambahProduk())));
        },
      ),
    );
  }
}
