import 'package:flutter/material.dart';

class MediaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;

    return Scaffold(
        appBar: AppBar(
          title: Text("Latihan Media Query"),
        ),
        body: (orientation == Orientation.portrait)
            ? Column(
                children: generateContainer(context),
              )
            : Row(
                children: generateContainer(context),
              ));
  }

  List<Widget> generateContainer(context) {
    var size = MediaQuery.of(context).size;

    return <Widget>[
      Container(
        color: Colors.red,
        width: size.width / 3,
        height: size.height / 5,
      ),
      Container(
        color: Colors.blue,
        width: size.width / 3,
        height: size.height / 5,
      ),
      Container(
        color: Colors.red,
        width: size.width / 3,
        height: size.height / 5,
      )
    ];
  }
}
