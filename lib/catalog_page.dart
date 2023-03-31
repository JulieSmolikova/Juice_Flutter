import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:the_juice/widgets/constants.dart';
import 'package:the_juice/widgets/list_view_catalog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class CatalogPage extends StatefulWidget {
  const CatalogPage({Key? key}) : super(key: key);

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {

  void isPressed() {
    setState(() {
      isDescending = !isDescending;
    });
  }

  late String _name;
  String _surname = '';
  String _color = '';
  String imagePath = 'https://cdn.pixabay.com/photo/2019/02/12/16/09/orange-3992583_960_720.jpg';

  // ImagePicker
  final ImagePicker _picker = ImagePicker();

  Future _selectFromGallery(String from) async {
    XFile? selectedFile = await _picker.pickImage(source: from == 'photo' ? ImageSource.camera : ImageSource.gallery);
    if (selectedFile == null) return;

    String uniqueFileName = DateTime.now().microsecondsSinceEpoch.toString();

    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImage = referenceRoot.child('images');
    Reference referenceImageToUpload = referenceDirImage.child(uniqueFileName);

    try{
      print('start');

      await referenceImageToUpload.putFile(File(selectedFile.path));

      print('end');

      imagePath = await referenceImageToUpload.getDownloadURL();
    }catch(e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: Container(
            width: size.width,
            height: size.height,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [KBlueDark, KBlueGrey, KBlueGrey],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    stops: [0.2, 0.7, 1])),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, right: 15, left: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.menu,
                        size: 40,
                        color: Colors.white.withOpacity(0.7),
                      ),
                      GestureDetector(
                        onTap: (){
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return SingleChildScrollView(
                                  child: AlertDialog(
                                    title: const Center(child: Text('Add position')),
                                    content: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  _selectFromGallery('photo');
                                                },
                                                icon: const Icon(Icons.photo_camera)),
                                            IconButton(
                                                onPressed: () {
                                                  _selectFromGallery('image');
                                                },
                                                icon: const Icon(Icons.image))
                                          ],
                                        ),
                                        const SizedBox(height: 15,),
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
                                              hintText: 'Price'),
                                          onChanged: (String value) {
                                            _color = value;
                                          },
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () {
                                            if (_name == '' || _surname == '' || _color == '' || imagePath == '') {
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
                                                'image': imagePath,
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
                                  ),
                                );
                              });
                        },
                        child: Container(
                          width: 37,
                          height: 37,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(width: 1, color: Colors.white.withOpacity(0.4),)
                          ),
                          child: Icon(Icons.add, size: 28, color: Colors.white.withOpacity(0.6),),
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                    top: size.height * 0.23,
                    left: size.width * 0.13,
                    child: Text(
                      '  the \nJUICE',
                      style: style_logo,
                    )
                ),
                Positioned(
                    top: size.height * 0.42,
                    left: size.width * 0.13,
                    child: Container(
                      height: size.height * 0.2,
                      width: size.width * 0.56,
                      color: Colors.transparent,
                      child: Text(
                        'We provide a variety \nof fresh juices with \nvarious flavors. get \nfresh juice easily',
                        style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 20, fontFamily: 'Playfair Display Regular'),
                      ),
                    )),
                Positioned(
                  top: size.height * 0.12,
                  right: -70,
                  child: Container(
                      color: Colors.transparent,
                      height: size.height * 0.35,
                      //width: size.width * 0.95,
                      child: Center(
                          child: Image.asset('assets/images/juice.png'))),
                ),
                Positioned(
                    top: size.height * 0.63,
                    left: size.width * 0.1,
                    child: Row(
                      children: [
                        Container(
                          height: size.height * 0.05,
                          width: size.width * 0.4,
                          color: Colors.transparent,
                          child: Text(
                            'Variation :',
                            style: style_var,
                          ),
                        ),
                        SizedBox(width: size.width * 0.25,),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              isPressed();
                            });
                          },
                          child: Container(
                              height: 30,
                              width: size.width * 0.15,
                              color: isDescending ? Colors.orange : Colors.green,
                              child: Center(child: Text('+/-'))
                          ),
                        )
                      ],
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
