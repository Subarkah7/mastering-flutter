import 'package:flutter/material.dart';

class FlexibleWidget extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flexible Layout")),
      body: Column(
        children: [
          Flexible(
              flex: 1,
              child: Row(
                children: [
                  Flexible(
                      flex: 1,
                      child: Container(
                        color: Colors.blue,
                      )),
                  Flexible(flex: 1, child: Container(color: Colors.green)),
                  Flexible(
                      flex: 1,
                      child: Container(
                        color: Colors.pink,
                      )),
                ],
              )),
          Flexible(
              flex: 2,
              child: Container(
                color: Colors.white,
              )),
          Flexible(
              flex: 1,
              child: Container(
                color: Colors.yellow,
              )),
        ],
      ),
    );
  }
}
