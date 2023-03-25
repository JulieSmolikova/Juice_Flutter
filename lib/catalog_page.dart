import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:the_juice/widgets/constants.dart';
import 'package:the_juice/widgets/list_view_catalog.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({Key? key}) : super(key: key);

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {

  late String _name;
  String _surname = '';
  String _color = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            width: size.width,
            height: size.height,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [KBlueDark, KBlueGrey],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.4, 1])),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, right: 15, left: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.menu,
                        size: 40,
                        color: Colors.white.withOpacity(0.7),
                      ),
                      IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Add position'),
                                    content: Column(
                                      children: [
                                        TextField(
                                          decoration: const InputDecoration(
                                              hintText: 'Name'),
                                          onChanged: (String value) {
                                            _name = value;
                                          },
                                        ),
                                        TextField(
                                          decoration: const InputDecoration(
                                              hintText: 'Surname'),
                                          onChanged: (String value) {
                                            _surname = value;
                                          },
                                        ),
                                        TextField(
                                          decoration: const InputDecoration(
                                              hintText: 'Color'),
                                          onChanged: (String value) {
                                            _color = value;
                                          },
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      ElevatedButton(
                                            onPressed: () {
                                              if (_name == '' || _surname == '' || _color == '') {
                                                showDialog(
                                                    context: context,
                                                    builder: (BuildContext context) {
                                                      return AlertDialog(
                                                        title: const Text('Error'),
                                                        content: const Text('All fields must be filled'),
                                                        actions: [
                                                          TextButton(
                                                              onPressed: (){
                                                                Navigator.of(context).pop();
                                                              },
                                                              child: const Text('OK'))
                                                        ],
                                                      );
                                                    });
                                              }else{
                                                FirebaseFirestore.instance.collection('items').add({
                                                  'name': _name,
                                                  'surname': _surname,
                                                  'color': _color,
                                                });
                                                Navigator.of(context).pop();
                                              }
                                            },
                                            child: const Text('Submit')),

                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Close')),
                                    ],
                                  );
                                });
                          },
                          icon: Icon(
                            Icons.add_circle,
                            size: 38,
                            color: Colors.white.withOpacity(0.7),
                          ))
                    ],
                  ),
                ),
                Positioned(
                    top: size.height * 0.23,
                    left: size.width * 0.13,
                    child: Text(
                      '   the \nJUICE',
                      style: style_logo,
                    )),
                Positioned(
                    top: size.height * 0.42,
                    left: size.width * 0.13,
                    child: Container(
                      height: size.height * 0.2,
                      width: size.width * 0.56,
                      color: Colors.transparent,
                      child: Text(
                        'We provide a variety \nof fresh juices with \nvarious flavors. get \nfresh juice easily',
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.7), fontSize: 23),
                      ),
                    )),
                Positioned(
                  top: size.height * 0.15,
                  right: -115,
                  child: Container(
                      color: Colors.transparent,
                      height: size.height * 0.3,
                      width: size.width * 0.95,
                      child: Center(
                          child: Image.asset('assets/images/juice.png'))),
                ),
                Positioned(
                    top: size.height * 0.63,
                    left: size.width * 0.1,
                    child: Container(
                      height: size.height * 0.05,
                      width: size.width * 0.4,
                      color: Colors.transparent,
                      child: Text(
                        'Variation :',
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.7), fontSize: 23),
                      ),
                    )),
                Positioned(
                    top: size.height * 0.69,
                    left: 0,
                    child: Container(
                        height: size.height * 0.2,
                        width: size.width,
                        color: Colors.transparent,
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 0.04),
                        child: const ListViewCatalog()))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
