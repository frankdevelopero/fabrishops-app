import 'package:fabrishop/ui/constants/colors.dart';
import 'package:fabrishop/ui/widgets/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StoreEditPage extends StatefulWidget {
  StoreEditPage({Key key}) : super(key: key);

  @override
  _StoreEditPageState createState() => _StoreEditPageState();
}

class _StoreEditPageState extends State<StoreEditPage> {
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
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.chevron_left, color: white, size: 32),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Editar mi tienda",
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
                  padding: EdgeInsets.all(30),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 118,
                        width: 118,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.grey.shade400,
                              child: ClipOval(
                                child: SizedBox(
                                  width: 170,
                                  height: 170,
                                  child: Image.asset(
                                    'assets/imgs/placeholder-store.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 80,
                              right: 0,
                              child: FloatingActionButton(
                                mini: true,
                                backgroundColor: primary,
                                child: Icon(Icons.camera_alt,
                                    color: white, size: 16),
                                onPressed: () {
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                  _showMenu();
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      CustomTextField(
                        label: 'Nombre de su tienda',
                        inputType: TextInputType.text,
                        validator: (String text) {},
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      _fieldWhatsapp(),
                      SizedBox(
                        height: 20.0,
                      ),
                      CustomTextField(
                        label: 'Url de su tienda',
                        inputFormatters: "[a-z]",
                        inputType: TextInputType.text,
                        validator: (String text) {},
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          Text("https://"),
                          Text(
                            "example",
                            style: TextStyle(color: primary),
                          ),
                          Text(".fabritienda.com"),
                        ],
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          child: Text('Actualizar'),
                          onPressed: () {
                            Navigator.popAndPushNamed(context, "product");
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(primary),
                            padding: MaterialStateProperty.all(
                              EdgeInsets.only(top: 15, bottom: 15),
                            ),
                            textStyle: MaterialStateProperty.all(
                              TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _fieldWhatsapp() {
    return CustomTextField(
      label: 'Whatsapp',
      inputType: TextInputType.phone,
      validator: (String text) {},
    );
  }

  _showMenu() {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: 15),
            Container(
              height: 5,
              width: 70,
              decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(16)),
            ),
            SizedBox(height: 10),
            Text(
              'Seleccionar imágen del producto',
              style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15),
            InkWell(
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Text(
                      "Tomar foto",
                    ),
                    Spacer(),
                    FaIcon(FontAwesomeIcons.camera, color: textColorSecondary)
                  ],
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Text("Seleccionar desde galería"),
                  Spacer(),
                  FaIcon(FontAwesomeIcons.images, color: textColorSecondary)
                ],
              ),
            ),
            Divider(),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.all(15),
                child: Row(
                  children: [
                    Text("Cancelar", style: TextStyle(color: red)),
                    Spacer(),
                    FaIcon(FontAwesomeIcons.times, color: red)
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
