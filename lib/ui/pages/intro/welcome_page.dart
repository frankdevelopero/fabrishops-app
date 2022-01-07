import 'package:fabrishop/ui/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: primary,
    ));
    return Scaffold(
      backgroundColor: white,
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.width * 0.30),
            Center(
              child: Image.asset(
                "assets/imgs/welcome.jpg",
                width: MediaQuery.of(context).size.width * 0.6,
              ),
            ),
            Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Bienvenido a Fabrishops",
                  style: TextStyle(fontSize: 22),
                ),
                SizedBox(height: 15),
                Text(
                  "¡Empecemos!, crea una cuenta o incia sesión",
                  style: TextStyle(fontSize: 13, color: textColorSecondary),
                ),
                SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text('Crear mi tienda'),
                    onPressed: () {
                      Navigator.pushNamed(context, "register");
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(primary),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.only(top: 15, bottom: 15)),
                      textStyle: MaterialStateProperty.all(
                        TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text('Ingresar a mi cuenta',
                        style: TextStyle(color: textColor)),
                    onPressed: () {
                      Navigator.pushNamed(context, "login");
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(white),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.only(top: 15, bottom: 15)),
                      textStyle: MaterialStateProperty.all(
                        TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
