
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ionicons/ionicons.dart';
import 'package:project/cartPage.dart';
import 'package:project/details_product.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
 
  final List _products = [];
  var _fireStoreInstance = FirebaseFirestore.instance;

 

  fetchProducts() async {
    QuerySnapshot qn =
        await _fireStoreInstance.collection("products").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _products.add({
          "product-name": qn.docs[i]["product-name"],
          "product-description": qn.docs[i]["product-description"],
          "product-price": qn.docs[i]["product-price"],
          "product-image": qn.docs[i]["product-image"],
        });
      }
    });
    return qn.docs;
  }

  @override
  void initState() {
    fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('e7ded7'),
      appBar: AppBar(
        backgroundColor: HexColor('e7ded7'),
        elevation: 0,
        title: const Text("Product List", style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(CartPage());
            },
            icon: const Icon(
              Ionicons.bag_outline,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
            ),
            
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: _products.length,
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(Detailsproduct(_products[index]));
                      },
                      child: Card(
                        elevation: 3,
                        child: Column(
                          children: [
                            AspectRatio(
                                aspectRatio: 2,
                                child: Container(
                                    color: HexColor('e7ded7'),
                                    child: Image.network(
                                      _products[index]["product-image"][0],
                                    ))),
                            Text("${_products[index]["product-name"]}", style: const TextStyle(fontStyle: FontStyle.italic, fontFamily: 'Open Sans')),
                            Text(
                                _products[index]["product-price"].toString()),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
