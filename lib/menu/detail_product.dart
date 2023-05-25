import 'package:flutter/material.dart';

class DetailProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Implementasi tampilan halaman detail produk
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
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child:
                        Image.asset('assets/logo.png', width: 100, height: 80),
                  ),
                  Container(
                    width: 48,
                  )
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.width * .8,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/1.png'),
                  fit: BoxFit.cover,
                ),
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/1.png'),
                        fit: BoxFit.cover,
                      ),
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/1b.png'),
                        fit: BoxFit.cover,
                      ),
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/1.png'),
                        fit: BoxFit.cover,
                      ),
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // padding: EdgeInsets.all(16),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: 100,
                    child: Text(
                      'OWARI Tshirts Gundam Game Time',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.favorite_border_outlined),
                    iconSize: 40,
                    color: Colors.black,
                    onPressed: () {
                      // Kode aksi saat tombol pencarian ditekan
                      // Tambahkan logika sesuai kebutuhan Anda
                    },
                  ),
                ],
              ),
            ),
            Container(
              // padding: EdgeInsets.all(16),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width * 0.35,
                    height: 100,
                    child: Column(
                      children: [
                        Text(
                          'PILIHAN\nWARNA',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        Container(
                          alignment: Alignment.center,
                          width: 100,
                          height: 30,
                          child: Text(
                            'HIJAU',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 0, 116, 116)),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 240, 240, 240),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width * 0.35,
                    height: 100,
                    child: Column(
                      children: [
                        Text(
                          'UKURAN\nTERSEDIA',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        Container(
                          alignment: Alignment.center,
                          width: 100,
                          height: 30,
                          child: Text(
                            'MEDIUM',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          decoration: BoxDecoration(color: Colors.white),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 0, 0, 0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
