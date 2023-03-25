import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:the_juice/juice_page.dart';

String globalName = '';
String globalSurname = '';
String globalColor = '';

class ListViewCatalog extends StatefulWidget {
  const ListViewCatalog({Key? key}) : super(key: key);

  @override
  State<ListViewCatalog> createState() => _ListViewCatalogState();
}

class _ListViewCatalogState extends State<ListViewCatalog> {

  void toItem(String nameFromBase, String surnameFromBase, String colorFromBase) {
    setState(() {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const JuicePage()),
      );
      globalName = nameFromBase;
      globalSurname = surnameFromBase;
      globalColor = colorFromBase;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('items').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator(),);
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: ((){
                  toItem(
                    snapshot.data?.docs[index].get('name'),
                    snapshot.data?.docs[index].get('surname'),
                    snapshot.data?.docs[index].get('color'),
                  );
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
                  width: 100,
                  height: 100,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(17)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(snapshot.data?.docs[index].get('name'),),
                      Text(snapshot.data?.docs[index].get('surname'),),
                      Text(snapshot.data?.docs[index].get('color'),),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }
}
