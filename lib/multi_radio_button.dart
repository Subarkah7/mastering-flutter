import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';

class MultiRadioButton extends StatefulWidget {
  @override
  _MultiRadioButtonState createState() => _MultiRadioButtonState();
}

class _MultiRadioButtonState extends State<MultiRadioButton> {
  Map<int, String> selectedValues = new Map<int, String>();

  @override
  void initState() {

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      for (int i = 0; i < 3; i++) {
        selectedValues.putIfAbsent(i, () => "Answer A");
      }

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Multi Radio Button Group'),
      ),
      body: Column(
        children: [
          Text('Pilihan Sulit !'),
          Expanded(
            child: ListView.builder(
                itemCount: selectedValues.length + 1,
                itemBuilder: (context, index) => index < selectedValues.length
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Question $index",
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          RadioButtonGroup(
                            orientation: GroupedButtonsOrientation.HORIZONTAL,
                            margin: const EdgeInsets.only(left: 12),
                            onSelected: (String selected) => setState(() {
                              selectedValues[index] = selected;
                            }),
                            labels: <String>['Answer A', 'Answer B'],
                            picked: selectedValues[index],
                            itemBuilder: (rb, text, index) {
                              return Container(
                                margin:
                                    EdgeInsets.only(right: MediaQuery.of(context).size.width / 4),
                                child: (Column(
                                  children: [rb, text],
                                )),
                              );
                            },
                          )
                        ],
                      )
                    : ElevatedButton(
                        onPressed: () => print(selectedValues), child: Text('Get Selected'))),
          )
        ],
      ),
    );
  }
}
