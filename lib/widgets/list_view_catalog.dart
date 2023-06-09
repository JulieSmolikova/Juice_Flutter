import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:the_juice/catalog_page.dart';
import 'package:the_juice/juice_page.dart';
import 'package:the_juice/widgets/constants.dart';

String globalName = '';
String globalSurname = '';
String globalColor = '';
String image = '';
bool isDescending = true;
int globalFavorite = 0;
dynamic globalSnapshot;
int globalIndex = 0;

class ListViewCatalog extends StatefulWidget {
  const ListViewCatalog({Key? key}) : super(key: key);

  @override
  State<ListViewCatalog> createState() => _ListViewCatalogState();
}

class _ListViewCatalogState extends State<ListViewCatalog> {

  void toItem(String nameFromBase, String surnameFromBase, String colorFromBase, String images, int favorites) {
    setState(() {
      Navigator.push(context, MaterialPageRoute(builder: (context) => JuicePage()),);
      globalName = nameFromBase;
      globalSurname = surnameFromBase;
      globalColor = colorFromBase;
      image = images;
      globalFavorite = favorites;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('items').orderBy('color', descending: isDescending).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator(),);
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              //final item = snapshot.data?.docs[index];
              return GestureDetector(
                onTap: ((){
                  toItem(
                    snapshot.data?.docs[index].get('name'),
                    snapshot.data?.docs[index].get('surname'),
                    snapshot.data?.docs[index].get('color'),
                    snapshot.data?.docs[index].get('image'),
                    snapshot.data?.docs[index].get('favorite'),
                  );
                  globalIndex = index;
                  globalSnapshot = snapshot;
                }),
                onLongPress: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('A you sure?'),
                          content: const Text('All data will be lost!!!'),
                          actions: [
                            TextButton(
                                onPressed: (){
                                  Navigator.of(context).pop();
                                },
                                child: const Text('NO')),
                            TextButton(
                                onPressed: (){
                                  FirebaseFirestore.instance.collection('items').doc(snapshot.data?.docs[index].id).delete();
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Yes! Delete it!')),
                          ],
                        );
                      });
                },
                child: Container(
                  height: size.height * 0.2,
                  width: size.width * 0.26,
                  clipBehavior: Clip.hardEdge,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(17)
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        child: SizedBox(
                            height: size.height * 0.2,
                            width: size.width * 0.26,
                            child: Image.network(
                              snapshot.data?.docs[index].get('image'),
                              fit: BoxFit.fitHeight,)),
                      ),
                      Positioned(
                          bottom: 5,
                          right: 5,
                          child: IconButton(
                            onPressed: (){
                              print('favorite');
                              if (snapshot.data?.docs[index].get('favorite') == 0) {
                                FirebaseFirestore.instance.collection('items').doc(snapshot.data?.docs[index].id).
                                update({'favorite': 1});
                              }else{
                                FirebaseFirestore.instance.collection('items').doc(snapshot.data?.docs[index].id).
                                update({'favorite': 0});
                              }
                            },
                            icon: Icon(snapshot.data?.docs[index].get('favorite') == 0
                              ? Icons.favorite_border
                              : Icons.favorite,
                              size: 40,
                              color: snapshot.data?.docs[index].get('favorite') == 0
                              ? Colors.white
                              : Colors.deepOrange,),
                          ))
                    ],
                  ),
                  ),
                );
            },);
        });
  }
}
