import 'package:fabrishop/data/api/product_api.dart';
import 'package:fabrishop/data/models/category.dart';
import 'package:fabrishop/data/models/product.dart';
import 'package:fabrishop/ui/constants/colors.dart';
import 'package:fabrishop/ui/constants/shared_constants.dart';
import 'package:fabrishop/ui/constants/shared_utils.dart';
import 'package:fabrishop/ui/widgets/custom_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProductPage extends StatefulWidget {
  ProductPage({Key key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final _productApi = ProductApi();
  List<Category> listCategories = [];
  List<Product> listProducts = [];
  bool isFetching = true;

  @override
  void initState() {
    super.initState();
    _getProducts();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: primary,
    ));
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
                      "Catálogo",
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
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: <Widget>[
                    Container(
                      constraints: BoxConstraints.expand(height: 50),
                      child: TabBar(
                        labelColor: primary,
                        indicatorColor: primary,
                        indicatorWeight: 3,
                        indicator: UnderlineTabIndicator(
                          borderSide: BorderSide(color: primary, width: 4),
                          insets: EdgeInsets.symmetric(horizontal: 90),
                        ),
                        indicatorSize: TabBarIndicatorSize.label,
                        tabs: [
                          Tab(
                            text: "Productos",
                          ),
                          Tab(text: "Categorías"),
                        ],
                      ),
                    ),
                    Divider(),
                    Expanded(
                      child: Container(
                        color: grey,
                        child: TabBarView(
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, "product_add");
                                  },
                                  child: Container(
                                    color: white,
                                    child: Padding(
                                      padding: EdgeInsets.all(15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Agregar producto"),
                                          FaIcon(FontAwesomeIcons.plus,
                                              color: accent)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: listProducts.length,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      Product product = listProducts[index];
                                      return Card(
                                        child: Container(
                                          color: white,
                                          child: Padding(
                                            padding: EdgeInsets.all(15),
                                            child: Row(
                                              children: [
                                                Image.network(product.image,
                                                    width: 70),
                                                SizedBox(width: 10),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      product.name,
                                                      style: TextStyle(
                                                          color: textColor,
                                                          fontSize: 16),
                                                    ),
                                                    Text(
                                                      "Laptops & PCs",
                                                      style: TextStyle(
                                                          color:
                                                              textColorSecondary,
                                                          fontSize: 13),
                                                    ),
                                                    Text(product.price
                                                        .toString()),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, "category_add");
                                  },
                                  child: Container(
                                    color: white,
                                    child: Padding(
                                      padding: EdgeInsets.all(15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Agregar categoría"),
                                          FaIcon(FontAwesomeIcons.plus,
                                              color: accent)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                _widgetCategoryBody()
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: CustomBottom(
        index: 0,
      ),
    );
  }

  getActions(int body) {
    switch (body) {
      case 0:
        return [
          Center(
            child: Row(
              children: [
                Text("Visitar"),
                SizedBox(width: 5),
                FaIcon(FontAwesomeIcons.globe),
                SizedBox(width: 10),
              ],
            ),
          )
        ]; // Home Screen

      case 1:
        return [
          Icon(Icons.home),
          Icon(Icons.settings),
        ]; // Settings Screen
    }
  }

  Widget _widgetCategoryBody() {
    return Expanded(
      child: ListView.builder(
        itemCount: listCategories.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          Category cat = listCategories[index];
          return Card(
            child: Container(
              color: white,
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Text(cat.name),
              ),
            ),
          );
        },
      ),
    );
  }

  _getProducts() async {
    listCategories = await _productApi.getHome(
        store: PreferenceUtils.getInt(SharedConstants.storeId));
    isFetching = false;
    listCategories.forEach((cat) {
      listProducts.addAll(cat.products);
    });

    setState(() {});
  }
}
