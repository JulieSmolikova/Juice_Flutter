import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:the_juice/basket.dart';
import 'package:the_juice/catalog_page.dart';
import 'package:the_juice/widgets/constants.dart';
import 'package:the_juice/widgets/list_view_catalog.dart';


class JuicePage extends StatefulWidget {
  const JuicePage({Key? key}) : super(key: key);

  @override
  State<JuicePage> createState() => _JuicePageState();
}

class _JuicePageState extends State<JuicePage> {

  void toItem(int favorites) {
    setState(() {
      globalFavorite = favorites;
    });
  }

  void _addToBasket(String globalName, String globalSurname, globalColor, image) {
    FirebaseFirestore.instance.collection('basket').add({
      'name': globalName,
      'surname': globalSurname,
      'color': globalColor,
      'image': image,
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SizedBox(
            width: size.width,
            height: size.height,
            child: Stack(
              children: [
                SizedBox(
                  width: size.width,
                  height: size.height,
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned.fill(
                    child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                  ),
                )),
                Padding(
                  padding: const EdgeInsets.only(top: 25, right: 25, left: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (() {
                          Navigator.of(context).pop();
                        }),
                        child: SizedBox(
                          width: 100,
                          child: Stack(
                            children: [
                              Icon(
                                Icons.arrow_back_ios_new_outlined,
                                size: 35,
                                color: Colors.white.withOpacity(0.1),
                              ),
                              Positioned(
                                top: -2,
                                left: 15,
                                child: Icon(
                                  Icons.arrow_back_ios_new_outlined,
                                  size: 40,
                                  color: Colors.white.withOpacity(0.6),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text(
                        '  the \nJUICE',
                        style: style_logo_mini,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 45.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          height: 200,
                          width: 150,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.8),
                                    blurRadius: 20,
                                    offset: const Offset(-15, -15)),
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.8),
                                    blurRadius: 20,
                                    offset: const Offset(15, 15))
                              ]),
                          child: Image.network(
                            image,
                            fit: BoxFit.cover,
                          )),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        globalName,
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 30,
                            fontFamily: 'Playfair Display Regular',
                            fontStyle: FontStyle.italic,
                            shadows: [
                              Shadow(
                                  color: Colors.black.withOpacity(0.8),
                                  blurRadius: 15,
                                  offset: const Offset(8, 8))
                            ]),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        globalSurname,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 18,
                            fontFamily: 'Playfair Display Regular',
                            shadows: [
                              Shadow(
                                  color: Colors.black.withOpacity(0.8),
                                  blurRadius: 15,
                                  offset: const Offset(8, 8))
                            ]),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        '\$ $globalColor',
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 23,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w500,
                            shadows: [
                              Shadow(
                                  color: Colors.black.withOpacity(0.8),
                                  blurRadius: 15,
                                  offset: const Offset(8, 8))
                            ]),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 260,
                          height: 37,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.4),
                                    blurRadius: 15,
                                    offset: const Offset(20, 15))
                              ],
                              border: Border.all(
                                  color: Colors.white.withOpacity(0.7),
                                  width: 2),
                              color: Colors.transparent,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          child: Center(
                              child: Text(
                            'Get Your Extra',
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 18),
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                    top: 160,
                    right: 115,
                    child: IconButton(
                      onPressed: () {
                        if (globalSnapshot.data?.docs[globalIndex].get('favorite') == 0) {
                          FirebaseFirestore.instance
                              .collection('items')
                              .doc(globalSnapshot.data?.docs[globalIndex].id)
                              .update({'favorite': 1});
                          setState(() {
                            if(globalFavorite == 0) {
                              globalFavorite = 1;
                            }else{
                              globalFavorite = 0;
                            }
                          });
                        } else {
                          FirebaseFirestore.instance
                              .collection('items')
                              .doc(globalSnapshot.data?.docs[globalIndex].id)
                              .update({'favorite': 0});
                          setState(() {
                            if(globalFavorite == 0) {
                              globalFavorite = 1;
                            }else{
                              globalFavorite = 0;
                            }
                          });
                        }
                      },
                      icon: Icon(
                          globalFavorite == 0
                              ? Icons.favorite_border
                              : Icons.favorite,
                          size: 35,
                          color: globalFavorite == 0
                              ? Colors.white
                              : Colors.deepOrange),
                    ),
                ),

                Positioned(
                  top: 200,
                  right: 115,
                  child: IconButton(
                    onPressed: () {
                      print('basket');
                      _addToBasket(
                        globalSnapshot.data?.docs[globalIndex].get('name'),
                        globalSnapshot.data?.docs[globalIndex].get('surname'),
                        globalSnapshot.data?.docs[globalIndex].get('color'),
                        globalSnapshot.data?.docs[globalIndex].get('image'),
                      );
                        },
                    icon: Container(
                      width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(50)
                        ),
                        child: Icon(Icons.shopping_basket_outlined, color: Colors.black.withOpacity(0.7),)),
                )),

                Positioned(
                  bottom: size.height * 0.04,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: (() {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Basket()),);
                          }),
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                                color: KBlueDark,
                                gradient: const LinearGradient(
                                    colors: [KBlueDark, KBlueGrey],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    stops: [0.4, 1.0]),
                                borderRadius:
                                const BorderRadius.all(Radius.circular(50)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.white.withOpacity(0.5),
                                      blurRadius: 40,
                                      offset: const Offset(-15, -10)),
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.5),
                                      blurRadius: 40,
                                      offset: const Offset(15, 10))
                                ]),
                            child: SizedBox(width: 30, height: 30,
                                child: Icon(Icons.shopping_basket_outlined, color: Colors.white.withOpacity(0.5),)),
                          ),
                        ),
                        SizedBox(width: size.width * 0.53,),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                                color: KBlueDark,
                                gradient: const LinearGradient(
                                    colors: [KBlueDark, KBlueGrey],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    stops: [0.4, 1.0]),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(50)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.white.withOpacity(0.5),
                                      blurRadius: 40,
                                      offset: const Offset(-15, -10)),
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.5),
                                      blurRadius: 40,
                                      offset: const Offset(15, 10))
                                ]),
                            child: Center(
                                child: Text(
                              'BUY',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.7), fontSize: 18),
                            )),
                          ),
                        ),
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
