

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/bottom_nav_pages/home.dart';

class ProductDetails extends StatefulWidget {

  var _product;
  ProductDetails(this._product);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProductDetailsState();
  }



}


class _ProductDetailsState extends State<ProductDetails> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.orange,
            child: IconButton(
              onPressed: () {
                Get.off(Home());
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 3.5,
                child: CarouselSlider(
                  items: widget._product['product-image'].map<Widget>((item) => Padding(
                    padding: const EdgeInsets.only(left: 3, right: 3),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(item),
                          fit: BoxFit.fitWidth
                        )
                      ),
                    ),
                  )).toList(),
                  options: CarouselOptions(
                    autoPlay: false,
                    enlargeCenterPage: true,
                    viewportFraction: 0.8,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                    onPageChanged: (val, CarouselPageChangedReason) {
                      setState(() {
                      });
                    },
                  ),
                  
                ),
                
              ),
              Text(
                widget._product['product-name'],
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              Text(
                widget._product['product-description'],

              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }

}