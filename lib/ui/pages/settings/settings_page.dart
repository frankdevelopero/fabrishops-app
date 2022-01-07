import 'package:fabrishop/ui/constants/colors.dart';
import 'package:fabrishop/ui/constants/shared_constants.dart';
import 'package:fabrishop/ui/constants/shared_utils.dart';
import 'package:fabrishop/ui/pages/intro/welcome_page.dart';
import 'package:fabrishop/ui/widgets/CustomTextField.dart';
import 'package:fabrishop/ui/widgets/custom_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
                      "Ajustes",
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
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      _itemUser(),
                      Row(
                        children: [
                          FaIcon(FontAwesomeIcons.userEdit,
                              color: textColorSecondary),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text("Editar mis datos",
                                  style: TextStyle(fontSize: 18)),
                              Text(
                                "Gestionar la información de tu cuenta",
                                style: TextStyle(
                                    fontSize: 14, color: textColorSecondary),
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
                      _itemLogout()
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: CustomBottom(index: 3),
    );
  }

  Widget _itemUser() {
    return Column(
      children: [
        CircleAvatar(
          radius: 35,
          backgroundImage: AssetImage('assets/imgs/placeholder-store.png'),
        ),
        SizedBox(height: 5),
        Text(
          "${PreferenceUtils.getString(SharedConstants.fullname)} ${PreferenceUtils.getString(SharedConstants.lastname)}",
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 5),
        Text(
          "${PreferenceUtils.getString(SharedConstants.email)}",
          style: TextStyle(fontSize: 12, color: primary),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget _itemLogout() {
    return InkWell(
      onTap: () {
        PreferenceUtils.clearPrefs();
        Navigator.pushAndRemoveUntil<dynamic>(
          context,
          MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => WelcomePage(),
          ),
          (route) => false,
        );
      },
      child: Row(
        children: [
          FaIcon(FontAwesomeIcons.signOutAlt, color: textColorSecondary),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Text("Cerrar sesión", style: TextStyle(fontSize: 18)),
              Text(
                "Haga clic aquí para cerrar sesión",
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
}
