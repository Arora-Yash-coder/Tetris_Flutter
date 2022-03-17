import 'package:flutter/material.dart';
import 'package:tetris/button.dart';

class MyGrid extends StatelessWidget {
  const MyGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: 180,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 10),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: MyButton(),
          );
        });
  }
}
