import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Juice extends ChangeNotifier{

  // final String name;
  // final String surname;
  // final String color;
  //
  // Juice ({
  //   required this.name,
  //   required this.surname,
  //   required this.color,
  // });

  void addToBase(String name, String surname, String color) {
    FirebaseFirestore.instance.collection('items').add({
      'name': name,
      'surname': surname,
      'color': color,
    });
  }
}