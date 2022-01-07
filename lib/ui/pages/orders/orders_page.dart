import 'package:fabrishop/ui/constants/colors.dart';
import 'package:fabrishop/ui/widgets/custom_bottom.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OrderPage extends StatefulWidget {
  OrderPage({Key key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 80,
              decoration: BoxDecoration(color: primary),
              child: Padding(
                padding: EdgeInsets.only(left: 5, bottom: 30),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Pedidos",
                      style: TextStyle(color: white, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: double.infinity,
              margin: EdgeInsets.only(
                top: 50,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    color: white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "19 de mayo 2021 - 2 productos",
                                  style: TextStyle(
                                      color: textColorSecondary, fontSize: 14),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Image.asset("assets/imgs/placeholder.jpg",
                                        width: 50),
                                    SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Macbook Air M1 2020",
                                          style: TextStyle(
                                              color: textColor, fontSize: 16),
                                        ),
                                        Text(
                                          "Laptops & PCs",
                                          style: TextStyle(
                                              color: textColorSecondary,
                                              fontSize: 13),
                                        ),
                                        Text("S/ 4599"),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Total: S/ 499  - #045",
                                  style:
                                      TextStyle(color: textColor, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: CustomBottom(
        index: 1,
      ),
    );
  }
}
