import 'package:fabrishop/data/api/store_api.dart';
import 'package:fabrishop/data/models/store.dart';
import 'package:fabrishop/ui/constants/colors.dart';
import 'package:fabrishop/ui/constants/shared_constants.dart';
import 'package:fabrishop/ui/constants/shared_utils.dart';
import 'package:fabrishop/ui/widgets/custom_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class StorePage extends StatefulWidget {
  StorePage({Key key}) : super(key: key);

  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  final _storeApi = StoreApi();
  bool isFetching = true;
  Store store;
  @override
  void initState() {
    super.initState();
    _getStoreData();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: primary,
    ));
    return Scaffold(
      backgroundColor: white,
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
                      "Mi tienda",
                      style: TextStyle(color: white, fontSize: 18),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        _bottomShare(context, store);
                      },
                      child: Center(
                        child: Row(
                          children: [
                            Text("Visitar", style: TextStyle(color: white)),
                            SizedBox(width: 5),
                            FaIcon(
                              FontAwesomeIcons.globe,
                              color: white,
                            ),
                            SizedBox(width: 15),
                          ],
                        ),
                      ),
                    )
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
              child: isFetching
                  ? Center(child: CircularProgressIndicator())
                  : SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundColor: accent,
                              radius: 38.0,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                backgroundImage: NetworkImage(store.image),
                                radius: 35.0,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              store.name,
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "http://192.168.0.17:8000/tienda/${store.slug}",
                              style: TextStyle(fontSize: 12, color: primary),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: Card(
                                    child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          FaIcon(FontAwesomeIcons.eye,
                                              color: blue_story),
                                          SizedBox(width: 10),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "+1025",
                                                style: TextStyle(fontSize: 16),
                                              ),
                                              Text(
                                                "Visitas a la tienda",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: textColorSecondary),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Card(
                                    child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          FaIcon(FontAwesomeIcons.moneyBillAlt,
                                              color: online),
                                          SizedBox(width: 10),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "S/ 1547",
                                                style: TextStyle(fontSize: 16),
                                              ),
                                              Text(
                                                "Total ventas",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: textColorSecondary),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                FaIcon(FontAwesomeIcons.shippingFast,
                                    color: textColorSecondary),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Opciones de envío",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      "Configura costo y método de envío",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: textColorSecondary),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                ),
                                Spacer(),
                                FaIcon(FontAwesomeIcons.chevronRight,
                                    color: textColorSecondary),
                              ],
                            ),
                            Divider(),
                            Row(
                              children: [
                                FaIcon(FontAwesomeIcons.creditCard,
                                    color: textColorSecondary),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Métodos de pago",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      "Configura los métodos de pagos",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: textColorSecondary),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                ),
                                Spacer(),
                                FaIcon(FontAwesomeIcons.chevronRight,
                                    color: textColorSecondary),
                              ],
                            ),
                            Divider(),
                            _itemStore(),
                            Divider(),
                            _itemContact(),
                            Divider(),
                          ],
                        ),
                      ),
                    ),
            )
          ],
        ),
      ),
      bottomNavigationBar: CustomBottom(index: 2),
    );
  }

  Widget _itemStore() {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, "store_edit");
      },
      child: Row(
        children: [
          FaIcon(FontAwesomeIcons.pencilRuler, color: textColorSecondary),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Text("Editar tienda", style: TextStyle(fontSize: 18)),
              Text(
                "Nombre, descripción, logo",
                style: TextStyle(fontSize: 14, color: textColorSecondary),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
          Spacer(),
          FaIcon(FontAwesomeIcons.chevronRight, color: textColorSecondary),
        ],
      ),
    );
  }

  Widget _itemContact() {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, "store_contact");
      },
      child: Row(
        children: [
          FaIcon(FontAwesomeIcons.shareAlt, color: textColorSecondary),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Text("Datos de contacto", style: TextStyle(fontSize: 18)),
              Text(
                "Redes sociales, dirección y whatsapp",
                style: TextStyle(fontSize: 14, color: textColorSecondary),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
          Spacer(),
          FaIcon(FontAwesomeIcons.chevronRight, color: textColorSecondary),
        ],
      ),
    );
  }

  _getStoreData() async {
    store = await _storeApi.getStoreData(
      idStore: PreferenceUtils.getInt(SharedConstants.storeId),
    );
    isFetching = false;
    setState(() {});
  }
}

void _bottomShare(context, Store store) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext bc) {
      return Container(
        child: Wrap(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  FaIcon(FontAwesomeIcons.shareAlt,
                      color: textColorSecondary, size: 24.0),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Comparte el enlace de tu catálogo para recibir más pedidos",
                      style: TextStyle(fontSize: 16, color: accent),
                    ),
                  )
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    store.name,
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "http://192.168.0.17:8000/tienda/${store.slug}",
                    style: TextStyle(fontSize: 14, color: primary),
                  ),
                ],
              ),
            ),
            Divider(),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.copy),
              title: Text('Copiar link'),
              subtitle: Text('Haga clic para copiar la url de su catálogo'),
              onTap: () {
                Clipboard.setData(ClipboardData(
                    text: "http://192.168.0.17:8000/tienda/${store.slug}"));
                Fluttertoast.showToast(
                  msg: "¡Link copiado!",
                );
              },
            ),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.chrome),
              title: Text('Visitar mi catálogo'),
              subtitle: Text('Haga clic para abrir en el navegador'),
              onTap: () async {
                await launch(
                  "http://192.168.0.17:8000/tienda/${store.slug}",
                  forceSafariVC: false,
                  forceWebView: false,
                );
              },
            ),
            Divider(),
            InkWell(
              onTap: () => {},
              child: Padding(
                padding:
                    EdgeInsets.only(top: 15, left: 20, bottom: 15, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Compartir en: ",
                      style: TextStyle(fontSize: 16),
                    ),
                    Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.facebook,
                          color: Colors.blue,
                          size: 26,
                        ),
                        SizedBox(width: 10),
                        FaIcon(FontAwesomeIcons.whatsapp,
                            color: Colors.green, size: 26),
                        SizedBox(width: 10),
                        FaIcon(FontAwesomeIcons.instagram,
                            color: Colors.pink, size: 26),
                        SizedBox(width: 10),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );
    },
  );
}
