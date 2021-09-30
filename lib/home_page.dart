import 'package:flutter/material.dart';
import 'package:mastering_flutter/multi_provider.dart';
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
          children: [
            MaterialButton(
              child: Text("Go to Second Page"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SecondPage();
                }));
              },
            ),
            MaterialButton(
              child: Text("Provider State Management"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return StateManagement();
                }));
              },
            ),
            MaterialButton(
              child: Text("Multi Provider State Management"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return MultiProviderState();
                }));
              },
            ),
          ],
        ),
      ),
    );
  }
}
