import 'package:flutter/material.dart';
import 'package:owari/menu/detail_product.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void navigateToDetailProduct() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailProductPage()),
    );
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    // Kode aksi saat tombol pencarian ditekan
                    // Tambahkan logika sesuai kebutuhan Anda
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Image.asset('assets/logo.png', width: 100, height: 80),
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    // Kode aksi saat tombol pencarian ditekan
                    // Tambahkan logika sesuai kebutuhan Anda
                  },
                ),
              ],
            ),
          ),
          // Container(
          //   padding: EdgeInsets.all(16),
          //   alignment: Alignment.center,
          //   child:
          // ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 140,
                            height: 140,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/1.png'),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          Container(
                            width: 140,
                            height: 140,
                            alignment: Alignment.center,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              alignment: Alignment.bottomRight,
                              child: Text(
                                'OWARI',
                                style: TextStyle(
                                    fontSize: 38,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white.withOpacity(0.8)),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                          Container(
                            width: 140,
                            height: 140,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            // Pengaturan opasitas di sini
                            child: Container(
                              padding: EdgeInsets.all(20),
                              alignment: Alignment.topLeft,
                              child: Text(
                                'New Design',
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          )
                        ],
                      ),
                      Stack(
                        children: [
                          Container(
                            width: 140,
                            height: 140,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/6.png'),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          Container(
                            width: 140,
                            height: 140,
                            alignment: Alignment.center,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              alignment: Alignment.bottomRight,
                              child: Text(
                                'OWARI',
                                style: TextStyle(
                                    fontSize: 38,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                          Container(
                            width: 140,
                            height: 140,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 105, 0, 0)
                                  .withOpacity(0.8),
                              borderRadius: BorderRadius.circular(10),
                            ), // Pengaturan opasitas di sini
                            child: Container(
                              padding: EdgeInsets.all(20),
                              alignment: Alignment.topLeft,
                              child: Text(
                                'New Product',
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  ////////////////////////////////
                  ///////PRODUKKKKKKKKK///////////
                  ////////////////////////////////
                  Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.center,
                    child: Text(
                      'Produk Terlaris',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  // Komponen-komponen custom
                  MarketPlaceItem(
                      title: 'Kaos Gundam',
                      description:
                          'kaos premium dengan bahan premium serta kualitas sablon premium',
                      price: '\$10',
                      image: 'assets/1.png',
                      onTap: navigateToDetailProduct,
                      ),
                  MarketPlaceItem(
                    title: 'Kaos GameMachine',
                    description:
                        'kaos premium dengan bahan premium serta kualitas sablon premium',
                    price: '\$20',
                    image: 'assets/2.jpg',
                    onTap: navigateToDetailProduct,
                  ),
                  MarketPlaceItem(
                    title: 'Item 3',
                    description:
                        'kaos premium dengan bahan premium serta kualitas sablon premium',
                    price: '\$15',
                    image: 'assets/3.png',
                    onTap: navigateToDetailProduct,
                  ),
                  MarketPlaceItem(
                    title: 'Item 4',
                    description:
                        'kaos premium dengan bahan premium serta kualitas sablon premium',
                    price: '\$25',
                    image: 'assets/4.png',
                    onTap: navigateToDetailProduct,
                  ),
                  MarketPlaceItem(
                    title: 'Item 5',
                    description:
                        'kaos premium dengan bahan premium serta kualitas sablon premium',
                    price: '\$30',
                    image: 'assets/5.png',
                    onTap: navigateToDetailProduct,
                  ),
                  MarketPlaceItem(
                    title: 'Item 6',
                    description:
                        'kaos premium dengan bahan premium serta kualitas sablon premium',
                    price: '\$30',
                    image: 'assets/6.png',
                    onTap: navigateToDetailProduct,
                  ),
                  MarketPlaceItem(
                    title: 'Item 5',
                    description:
                        'kaos premium dengan bahan premium serta kualitas sablon premium',
                    price: '\$30',
                    image: 'assets/7.jpg',
                    onTap: navigateToDetailProduct,
                  ),
                  MarketPlaceItem(
                    title: 'Item 5',
                    description:
                        'kaos premium dengan bahan premium serta kualitas sablon premium',
                    price: '\$30',
                    image: 'assets/8.png',
                    onTap: navigateToDetailProduct,
                  ),
                  MarketPlaceItem(
                    title: 'Item 5',
                    description:
                        'kaos premium dengan bahan premium serta kualitas sablon premium',
                    price: '\$30',
                    image: 'assets/9.png',
                    onTap: navigateToDetailProduct,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

class MarketPlaceItem extends StatelessWidget {
  final String title;
  final String description;
  final String price;
  final String image;
  final VoidCallback onTap;

  MarketPlaceItem({
    required this.title,
    required this.description,
    required this.price,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, 
      child:  Card(
      margin: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            image,
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
      )
    );
  }
}
