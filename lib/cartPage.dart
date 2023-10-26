

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ionicons/ionicons.dart';
import 'package:project/bottom_nav_pages/home.dart';

class CartPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    
    return CartPageState();
  }

}

class CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      backgroundColor: HexColor('e7ded7'),
      appBar: AppBar(
        backgroundColor: HexColor('e7ded7'),
        elevation: 0,
        title: const Text(
          "Cart Products",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Ionicons.chevron_back,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.off(Home());
            },
            icon: const Icon(
              Ionicons.home_outline,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("users-cart-items").doc(FirebaseAuth.instance.currentUser!.email).collection("items").snapshots(),
          builder: (context, AsyncSnapshot <QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text("Something wrong"));
            }

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (_, index) {
                DocumentSnapshot _documentsSnapShot = snapshot.data!.docs[index];
                return Card(
                  child: ListTile(
                    leading: Text(_documentsSnapShot['name']),
                    title: Text(
                    "\ ${_documentsSnapShot['price']}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  trailing: GestureDetector(
                    child: const CircleAvatar(
                      child: Icon(Icons.remove_circle_outline),
                
                    ),
                    onTap: () {
                      FirebaseFirestore.instance.collection("users-cart-items").doc(FirebaseAuth.instance.currentUser!.email).collection("items").doc(_documentsSnapShot.id).delete();
                    },
                  ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

}