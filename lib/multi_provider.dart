import 'package:flutter/material.dart';
import 'package:mastering_flutter/widgets/cart.dart';
import 'package:mastering_flutter/widgets/money.dart';
import 'package:provider/provider.dart';

class MultiProviderState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Money>(
          create: (context) => Money(),
        ),
        ChangeNotifierProvider<Cart>(create: (context) => Cart())
      ],
      child: Scaffold(
        floatingActionButton: Consumer<Money>(
          builder: (context, money, _) => Consumer<Cart>(
            builder: (context, cart, _) => FloatingActionButton(
              onPressed: () {
                if (money.balance >= 500) {
                  cart.quantity += 1;
                  money.balance -= 500;
                }
              },
              child: Icon(
                Icons.add_shopping_cart,
              ),
              backgroundColor: Colors.purple,
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: Text("Multi Provider"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Balance",
                  ),
                  Container(
                    height: 40,
                    width: 200,
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.purple, width: 2)),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Consumer<Money>(
                        builder: (context, money, _) => Text(
                          money.balance.toString(),
                          style: TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Container(
                height: 40,
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black, width: 2)),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Consumer<Cart>(
                    builder: (context, cart, _) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Apple (500) x " + cart.quantity.toString(),
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          (500 * cart.quantity).toString(),
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
