

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ionicons/ionicons.dart';
import 'package:project/bottom_nav_pages/home.dart';
import 'package:project/cartPage.dart';

class Detailsproduct extends StatefulWidget {

  var _productm;
  Detailsproduct(this._productm);

  @override
  State<StatefulWidget> createState() => _DetailsProductState();



}


class _DetailsProductState extends State<Detailsproduct> {


  Future AddCart() async {      // It's an Asynchronus AddCart Custom Function. It Updates the cart list of every particular user in database
    
    final FirebaseAuth _auth = FirebaseAuth.instance;   // First we create a variable of FirebaseAuth 
    var currentUser = _auth.currentUser;                // Then we create a varriable and store User's id.
    CollectionReference _collection = FirebaseFirestore.instance.collection("users-cart-items");
    return _collection.doc(currentUser!.email).collection("items").doc().set(
      {
        "name": widget._productm["product-name"],
        "price": widget._productm["product-price"],
        "image": widget._productm["product-image"]
      }
    ).then((value) => Get.snackbar(
      "Added",
      "Product Added Successfully to cart",
      icon: const Icon(Icons.add_shopping_cart_outlined),
      shouldIconPulse: true,
      barBlur: 20,
      isDismissible: true,
      duration: const Duration(seconds: 3),
    ));
  }





  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      backgroundColor: HexColor('e7ded7'),
      appBar: AppBar(
        backgroundColor: HexColor('e7ded7'),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.off(Home());
          },
          icon: const Icon(
            Ionicons.chevron_back,
            color: Colors.black,
          ),
        ),
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
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height*.35,
            padding: const EdgeInsets.only(bottom: 30),
            width: double.infinity,
            child: CarouselSlider(
              items: widget._productm['product-image'].map<Widget>((item) => Padding(
                padding: const EdgeInsets.only(left: 3, right: 3),
                child: Container(
                  margin: const EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: NetworkImage(item),
                      fit: BoxFit.contain
                    )
                  ),
                ),
              )).toList(),
              options: CarouselOptions(
                height: 180.0,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                viewportFraction: 0.8,
              ),
            )


          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 40, right: 14, left: 14),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    )
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                         widget._productm['product-name'],
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget._productm['product-name'],
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              widget._productm['product-price'],
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Text(
                          widget._productm['product-description'],
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          child: Center(
                            child: ElevatedButton(
                          onPressed: () {
                            AddCart();
                          },
                          child: const Text(
                            "Buy"
                          ),
                        ),
                          ),
                        )
                        

                      ],
                      
                    ),
                    
                  ),
                  
                ),
                
              ],
            ),
          ),
        ],
        
      ),

     
    
    );
  }

}