import 'package:fabrishop/data/api/auth_api.dart';
import 'package:fabrishop/ui/constants/colors.dart';
import 'package:fabrishop/ui/widgets/CustomTextField.dart';
import 'package:fabrishop/utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _authApi = AuthApi();

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
              height: 130,
              decoration: BoxDecoration(color: primary),
              child: Padding(
                padding: EdgeInsets.only(left: 15, bottom: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
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
                      "¡Bienvenido de nuevo a fabrishop!",
                      style: TextStyle(color: white, fontSize: 22),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: double.infinity,
              margin: EdgeInsets.only(
                top: 110,
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
                      Text(
                        "Ingresa tus datos de acceso para administrar tus ventas y catálogo.",
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Form(
                        child: Column(
                          children: <Widget>[
                            CustomTextField(
                              label: 'Correo electrónico',
                              controller: _emailController,
                              inputType: TextInputType.emailAddress,
                              suffixIcon: Icons.email,
                              validator: (String text) {},
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            CustomTextField(
                              label: 'Contraseña',
                              isSecure: true,
                              controller: _passwordController,
                              inputType: TextInputType.visiblePassword,
                              suffixIcon: Icons.lock,
                              validator: (String text) {},
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          child: Text('Ingresar'),
                          onPressed: () {
                            if (_emailController.text != "" &&
                                _passwordController.text != "") {
                              _login(_emailController.text,
                                  _passwordController.text);
                            } else {}
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
                      SizedBox(
                        height: 20.0,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          '¿Olvidaste tu contraseña?',
                          style: TextStyle(color: primary),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.3,
                      ),
                      Row(
                        children: [
                          Text(
                            '¿No tienes una cuenta?',
                            style: TextStyle(),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            'Crea una cuenta',
                            style: TextStyle(color: primary),
                          ),
                        ],
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

  _login(String email, String password) async {
    Dialogs.showLoaderDialog(context, "Iniciando sesión...");
    final resp = await _authApi.login(email: email, password: password);
    Navigator.pop(context);
    if (resp.status) {
      Navigator.popAndPushNamed(context, "product");
    } else {
      Dialogs.alert(context, title: "Iniciar sesión", message: resp.message);
    }
  }
}
