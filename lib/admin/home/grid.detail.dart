import 'package:flutter/material.dart';
import '/admin/model/product.dart';

class GridDetails extends StatefulWidget {
  final Product product;
  GridDetails({required this.product});

  @override
  _GridDetailsState createState() => _GridDetailsState();
}

class _GridDetailsState extends State<GridDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black,),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Hero(
            //   tag: "assets${widget.product.idBarang}",
            //   child: FadeInImage.assetNetwork(
            //     placeholder: "assets/load.png",
            //     image: widget.product.urlGambar),
            // ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
