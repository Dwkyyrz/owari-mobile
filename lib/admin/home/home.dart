import 'package:flutter/material.dart';
import 'package:owari/admin/home/grid.detail.dart';
import 'package:owari/admin/home/grid_cell.dart';
import 'package:owari/admin/model/network_request.dart';
import 'package:owari/admin/model/product.dart';
import 'package:owari/admin/admn/tambahproduk.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  gridView(AsyncSnapshot<List<Product>> snapshot) {
    return Padding(
        padding: EdgeInsets.all(5),
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 1,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          children: snapshot.data!.map((product) {
            return GestureDetector(
              child: GridTile(
                child: ProductCell(product),
              ),
              onTap: () {
                gotoDetailPage(context, product);
              },
            );
          }).toList(),
        ));
  }

  gotoDetailPage(BuildContext context, Product product) {
    Navigator.push(
      context, MaterialPageRoute(builder: (BuildContext context) => GridDetails(product: product))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(
          context, MaterialPageRoute(builder: (context) => TambahProduk()));
      },
      child: Icon(Icons.add),
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
              child: FutureBuilder<List<Product>>(
                  future: NetworkRequest.fetchProduct(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text('Error ${snapshot.error}'));
                    } else if (snapshot.hasData) {
                      return gridView(snapshot);
                    }
                    return CircularProgressIndicator();
                  }))
        ],
      ),
    );
  }
}
