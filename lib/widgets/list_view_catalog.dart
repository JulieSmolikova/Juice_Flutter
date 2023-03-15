import 'package:flutter/material.dart';

class ListViewCatalog extends StatelessWidget {
  const ListViewCatalog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: ((){
            Navigator.of(context).pushNamed('/juice_page');
          }),
          child: Container(
            width: 100,
            height: 100,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(17)
            ),
          ),
        );
      },
   );
  }
}
