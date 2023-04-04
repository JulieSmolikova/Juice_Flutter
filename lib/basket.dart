import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:the_juice/juice_page.dart';
import 'package:the_juice/widgets/constants.dart';

class Basket extends StatelessWidget {
  const Basket({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          const SizedBox(height: 40,),
          Container(
                width: size.width,
                height: size.height * 0.75,
                color: KBlueGrey.withOpacity(0.4),
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('basket').orderBy('name', descending: false).snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {return const Center(child: CircularProgressIndicator(),);}
                    return ListView.builder(
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: ListTile(
                            title: Text(snapshot.data?.docs[index].get('name')),
                            subtitle: Text(snapshot.data?.docs[index].get('color')),
                            leading: CircleAvatar(
                              radius: 40,
                              child: Image.network(snapshot.data?.docs[index].get('image')),),
                            trailing: IconButton(
                              onPressed: () {
                                FirebaseFirestore.instance.collection('basket').doc(snapshot.data?.docs[index].id).delete();
                              },
                              icon: Icon(Icons.cancel, color: Colors.red.shade900,),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
          const SizedBox(height: 50,),
          GestureDetector(
            onTap: (){
              Navigator.of(context).pop();
            },
            child: Container(
              height: 35,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(30)
              ),
              child: const Center(child: Icon(Icons.arrow_back_outlined),),
            ),
          )
        ],
      )
    );
  }
}
