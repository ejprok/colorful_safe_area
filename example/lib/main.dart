import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ColorfulSafeArea Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int numberOfTiles = 100;

    return Scaffold(
      backgroundColor: Colors.blue,
      resizeToAvoidBottomInset: true,
      body: ColorfulSafeArea(
        // allowOverflow: true,
        overflowTappable: true,
        bottom: false,
        minimum: EdgeInsets.only(top: 20, left: 30, right: 30, bottom: 200),
        color: Colors.white.withOpacity(0.7),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.all(10),
              width: 300,
              height: 200,
              color: Colors.red,
              child: TextField(),
            );
          },
          itemCount: numberOfTiles,
        ),
      ),

      // body: SafeArea(
      //   bottom: false,
      //   minimum: EdgeInsets.only(top: 20, left: 30, right: 30, bottom: 200),
      //   child: ListView.builder(
      //     itemBuilder: (context, index) {
      //       return Container(
      //         margin: EdgeInsets.all(10),
      //         width: 300,
      //         height: 200,
      //         color: Colors.red,
      //         child: TextField(),
      //       );
      //     },
      //     itemCount: numberOfTiles,
      //   ),
      // ),
    );
  }
}
