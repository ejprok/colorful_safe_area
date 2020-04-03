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
        body: ColorfulSafeArea(
          allowOverflow: true,
          color: Colors.white.withOpacity(0.7),
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(10),
                width: 300,
                height: 200,
                color: Colors.red,
              );
            },
            itemCount: numberOfTiles,
          ),
        ));
  }
}
