import 'package:flutter/material.dart';
import 'package:mastering_flutter/bloc_state.dart';
import 'package:mastering_flutter/draggable_floating_action.dart';
import 'package:mastering_flutter/multi_provider.dart';
import 'package:mastering_flutter/multi_radio_button.dart';
import 'package:mastering_flutter/page/pdf_page.dart';
import 'package:mastering_flutter/provider_state.dart';
import 'package:mastering_flutter/second_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              minWidth: 300,
              color: Colors.blue[100],
              child: Text("Go to Second Page"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SecondPage();
                }));
              },
            ),
            MaterialButton(
                minWidth: 300,
                color: Colors.blue[100],
                child: Text("Draggable Floating Action"),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return DraggableFloatingActionCustom();
                  }));
                }),
            MaterialButton(
                minWidth: 300,
                color: Colors.blue[100],
                child: Text("Multiple Radio Button"),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return MultiRadioButton();
                  }));
                }),
            MaterialButton(
                minWidth: 300,
                color: Colors.blue[100],
                child: Text("Generate Pdf"),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return PdfPage();
                  }));
                 
            }),
            MaterialButton(
              minWidth: 300,
              color: Colors.blue[100],
              child: Text("Provider State Management"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return StateManagement();
                }));
              },
            ),
            MaterialButton(
              minWidth: 300,
              color: Colors.blue[100],
              child: Text("Multi Provider State Management"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return MultiProviderState();
                }));
              },
            ),
            MaterialButton(
              minWidth: 300,
              color: Colors.blue[100],
              child: Text("BloC Tanpa Libray"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return BlocWithoutLibrary();
                }));
              },
            ),
          ],
        ),
      ),
    );
  }
}
