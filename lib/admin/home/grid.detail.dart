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
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: "assets${widget.product.id}",
              child: FadeInImage.assetNetwork(
                placeholder: "assets/load.png",
                image: widget.product.url),
            ),
            SizedBox(height: 30),
            OutlinedButton(
              child: Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        ),
      ),
    );
  }
}
