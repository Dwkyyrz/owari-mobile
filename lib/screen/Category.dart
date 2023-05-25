// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  List catList = ["Game Series", "Music Series", "Anime Series"];

  //sek image list ambek catlist belakangan ae

<<<<<<< HEAD
  List imgList = [
    "banner1",
    "",
    ""
  ];
=======
  List imgList = ["ABCD", "EFGH", "IJKL"];
>>>>>>> 2d82ec620e5753ec7381ee0ff47be9c3ff3f19ba

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 20, left: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 1.5,
                        decoration: BoxDecoration(
                          color: Color(0xFFF7F8FA),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            label: Text("Find Your Prduct"),
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.search,
                                size: 30, color: Colors.grey),
                          ),
                        ),
                      ),
<<<<<<< HEAD
                    ),
                    Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Color(0xFFF7F8FA),
                        borderRadius: BorderRadius.circular(10) 
                        ),
                        child: Icon(
                          Icons.notifications_none,
                          size: 30,
                          color: Colors.grey,
                        ),
                    )
                  ],
                ),
=======
                      Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(color: Color(1010)),
                      )
                    ],
                  ),
>>>>>>> 2d82ec620e5753ec7381ee0ff47be9c3ff3f19ba
                ),
                Container(
                  margin: EdgeInsets.only(right: 25, top: 20),
                  alignment: Alignment.center,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset("assets/banner1.png",
                    width: MediaQuery.of(context).size.width / 1.2,
                    fit: BoxFit.contain,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: EdgeInsets.only(top: 25),
                    child: Row(
                      children: [
                        for(int i=0; i<catList.length; i++)
                        Container(
                          margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: catList[i] == "All"
                            ? Color(0xFFFD725A) : Color.fromARGB(255, 205, 205, 205),
                            borderRadius: BorderRadius.circular(18)
                          ),
                          child: Text(
                            catList[i],
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
