import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:the_juice/juice_page.dart';
import 'package:the_juice/widgets/constants.dart';

String globalName = '';
String globalSurname = '';
String globalColor = '';
String image = '';

class ListViewCatalog extends StatefulWidget {
  const ListViewCatalog({Key? key}) : super(key: key);

  @override
  State<ListViewCatalog> createState() => _ListViewCatalogState();
}

class _ListViewCatalogState extends State<ListViewCatalog> {


  void toItem(String nameFromBase, String surnameFromBase, String colorFromBase, String images) {
    setState(() {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const JuicePage()),
      );
      globalName = nameFromBase;
      globalSurname = surnameFromBase;
      globalColor = colorFromBase;
      image = images;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
                    snapshot.data?.docs[index].get('image'),
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
                  height: size.height * 0.2,
                  width: size.width * 0.26,
                  clipBehavior: Clip.hardEdge,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(17)
                  ),
                  child: Stack(
                    children: [
                      Positioned(top:0, child: SizedBox(height: size.height * 0.2,
                          width: size.width * 0.26, child: Image.network(snapshot.data?.docs[index].get('image'), fit: BoxFit.fitHeight,))),
                      //Center(child: Text(snapshot.data?.docs[index].get('name'),)),
                      //Positioned(bottom: 5, right: 35, child: Text(snapshot.data?.docs[index].get('color'),)),
                    ],
                  ),

                  // Column(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                        //Flexible(child: Image.network(snapshot.data?.docs[index].get('image'))),
                        // Text(snapshot.data?.docs[index].get('name'),),
                        // Text(snapshot.data?.docs[index].get('surname'),),
                        // Text(snapshot.data?.docs[index].get('color'),),
                    //   ],),

                  ),
                );
            },);
        });
  }
}
