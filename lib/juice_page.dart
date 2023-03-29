import 'package:flutter/material.dart';
import 'package:the_juice/widgets/constants.dart';
import 'package:the_juice/widgets/list_view_catalog.dart';

class JuicePage extends StatefulWidget {
  const JuicePage({Key? key}) : super(key: key);

  @override
  State<JuicePage> createState() => _JuicePageState();
}

class _JuicePageState extends State<JuicePage> {
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
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    GestureDetector(
                      onTap: ((){
                        Navigator.of(context).pop();
                      }),
                      child: Icon(
                        Icons.menu,
                        size: 40,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                    Text(
                      '   the \nJUICE',
                      style: style_logo_mini,
                    )
                  ],
                ),
                ),
                
                Positioned(
                    top: size.height * 0.17,
                    left: size.width * 0.29,
                    child: Container(color: Colors.transparent, height: 200, width: 150, child: Image.asset('assets/images/i5.png', fit: BoxFit.cover,))),

                Positioned(
                    top: size.height * 0.45,
                    left: size.width * 0.33,
                    child: Text(
                      globalName,
                      style: const TextStyle(color: Colors.white, fontSize: 30),
                    )),

                Positioned(
                    top: size.height * 0.51,
                    left: size.width * 0.21,
                    child: Container(
                      height: size.height * 0.12,
                      width: size.width * 0.6,
                      color: Colors.transparent,
                      child: Text(
                        globalSurname,
                        style: const TextStyle(color: Colors.white, fontSize: 21),
                      ),
                    )),

                Positioned(
                    top: size.height * 0.64,
                    left: size.width * 0.43,
                    child: Container(
                      height: size.height * 0.12,
                      width: size.width * 0.6,
                      color: Colors.transparent,
                      child: Text(
                        '\$ $globalColor',
                        style: const TextStyle(color: Colors.white, fontSize: 21),
                      ),
                    )),

                Positioned(
                    top: size.height * 0.73,
                    left: size.width * 0.17,
                    child: GestureDetector(
                      onTap: (){},
                      child: Container(
                        width: 260,
                        height: 37,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white.withOpacity(0.7), width: 2),
                          color: Colors.transparent,
                          borderRadius: const BorderRadius.all(Radius.circular(10))
                        ),
                        child: Center(child: Text('Get Your Extra', style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 18),)),
                      ),
                    )),
                
                Positioned(
                  bottom: size.height * 0.04,
                  right: size.width * 0.08,
                  child: GestureDetector(
                    onTap: (){},
                    child: Container(width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                          //border: Border.all(color: Colors.white.withOpacity(0.7), width: 2),
                          color: KBlueDark,
                          borderRadius: BorderRadius.all(Radius.circular(50))
                      ),
                      child: Center(child: Text('BUY', style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 18),)),
                  ),
                ),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
