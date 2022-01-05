import 'package:flutter/material.dart';
import 'package:mastering_flutter/widgets/color_bloc.dart';

class BlocWithoutLibrary extends StatefulWidget {
  @override
  _BlocWithoutLibraryState createState() => _BlocWithoutLibraryState();
}

class _BlocWithoutLibraryState extends State<BlocWithoutLibrary> {
  ColorBloc bloc = ColorBloc();

  @override
  void dispose() {
    bloc.disopose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BloC Tanpa Libray"),
      ),
      body: Center(
          child: StreamBuilder(
        stream: bloc.stateStream,
        initialData: Colors.amber,
        builder: (context, snapshot) {
          return AnimatedContainer(
              width: 100,
              height: 100,
              color: snapshot.data,
              duration: Duration(milliseconds: 500));
        },
      )),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
              backgroundColor: Colors.amber,
              onPressed: () {
                bloc.eventSink.add(ColorEvent.to_ember);
              }),
          SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () {
              bloc.eventSink.add(ColorEvent.to_light_blue);
            },
            backgroundColor: Colors.lightBlue,
          )
        ],
      ),
    );
  }
}
