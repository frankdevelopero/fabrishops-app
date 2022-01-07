import 'package:fabrishop/ui/constants/colors.dart';
import 'package:fabrishop/ui/widgets/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:country_code_picker/country_code_picker.dart';

class StoreContactPage extends StatefulWidget {
  StoreContactPage({Key key}) : super(key: key);

  @override
  _StoreContactPageState createState() => _StoreContactPageState();
}

class _StoreContactPageState extends State<StoreContactPage> {
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
                      "Datos de contacto",
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 20.0,
                      ),
                      _fieldWhatsapp(),
                      SizedBox(
                        height: 20.0,
                      ),
                      _fieldFacebook(),
                      Text(
                        "Ingresa url de la página(opcional)",
                        style: TextStyle(color: textColorSecondary),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      _fieldInstagram(),
                      Text(
                        "Ingresa url de la cuenta(opcional)",
                        style: TextStyle(color: textColorSecondary),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      _fieldAddress(),
                      Text(
                        "Ingresa la dirección de su tienda(opcional)",
                        style: TextStyle(color: textColorSecondary),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      SizedBox(
                        height: 20.0,
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
    return Row(
      children: [
        CountryCodePicker(
          onChanged: _onCountryChange,
          onInit: _onCountryChange,
          initialSelection: 'PE',
          favorite: ['+51', 'PE'],
          showCountryOnly: false,
          showOnlyCountryWhenClosed: false,
          alignLeft: false,
        ),
        Flexible(
          child: CustomTextField(
            label: 'Whatsapp',
            inputType: TextInputType.phone,
            validator: (String text) {},
          ),
        )
      ],
    );
  }

  void _onCountryChange(CountryCode countryCode) {
    FocusScope.of(context).requestFocus(new FocusNode());
    print("New Country selected: " + countryCode.toString());
  }

  Widget _fieldFacebook() {
    return CustomTextField(
      label: 'Facebook',
      inputType: TextInputType.text,
      validator: (String text) {},
    );
  }

  Widget _fieldInstagram() {
    return CustomTextField(
      label: 'Instagram',
      inputType: TextInputType.text,
      validator: (String text) {},
    );
  }

  Widget _fieldAddress() {
    return CustomTextField(
      label: 'Dirección',
      inputType: TextInputType.text,
      validator: (String text) {},
    );
  }
}
