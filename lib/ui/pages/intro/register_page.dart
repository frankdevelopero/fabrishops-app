import 'package:fabrishop/ui/constants/colors.dart';
import 'package:fabrishop/ui/widgets/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:im_stepper/stepper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:io';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController firsnameController = new TextEditingController();
  TextEditingController lastnameController = new TextEditingController();

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  TextEditingController storeNameController = new TextEditingController();
  TextEditingController storeUrlController = new TextEditingController();

  final ImagePicker _picker = ImagePicker();
  File _storeImage;
  int activeStep = 0;
  int upperBound = 2;
  String slugStore = "mitienda";

  @override
  void initState() {
    super.initState();
    _listenOnChanged();
  }

  @override
  void dispose() {
    super.dispose();
    storeUrlController.dispose();
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
              height: 130,
              decoration: BoxDecoration(color: primary),
              child: Padding(
                padding: EdgeInsets.only(left: 15, bottom: 30),
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
                      width: 15,
                    ),
                    Text(
                      "Crear nueva tienda",
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
                top: 80,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 15),
                child: Container(
                  child: Column(
                    children: [
                      IconStepper(
                        stepRadius: 27,
                        lineLength: MediaQuery.of(context).size.width * 0.23,
                        enableNextPreviousButtons: false,
                        activeStepColor: primary,
                        steppingEnabled: false,
                        activeStepBorderColor: primary,
                        lineColor: primary,
                        icons: [
                          Icon(Icons.manage_accounts_rounded, color: white),
                          Icon(Icons.store, color: white),
                          Icon(Icons.verified_user, color: white),
                        ],
                        activeStep: activeStep,
                        onStepReached: (index) {
                          setState(() {
                            activeStep = index;
                          });
                        },
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                            child: Column(
                          children: [
                            Divider(),
                            header(),
                            setContent(),
                          ],
                        )),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: previousButton(),
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              child: nextButton(),
                            )
                          ],
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

  Widget setContent() {
    return activeStep == 0
        ? userData()
        : activeStep == 1
            ? storeData()
            : accessData();
  }

  Widget userData() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Column(
        children: [
          CustomTextField(
            controller: firsnameController,
            label: 'Nombres',
            inputType: TextInputType.text,
            validator: (String text) {},
          ),
          SizedBox(
            height: 15.0,
          ),
          CustomTextField(
            controller: lastnameController,
            label: 'Apellidos completos',
            isSecure: false,
            inputType: TextInputType.text,
            validator: (String text) {},
          ),
        ],
      ),
    );
  }

  Widget storeData() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 0),
      child: Column(
        children: [
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
                      child: _storeImage != null
                          ? Image.file(
                              _storeImage,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
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
                    child: Icon(Icons.camera_alt, color: white, size: 16),
                    onPressed: () {
                      _showMenu();
                    },
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 20),
          CustomTextField(
            controller: storeNameController,
            label: 'Nombre de su tienda',
            inputType: TextInputType.text,
            validator: (String text) {},
          ),
          SizedBox(
            height: 20.0,
          ),
          CustomTextField(
            controller: storeUrlController,
            label: 'Subdminio de su tienda',
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
                slugStore,
                style: TextStyle(color: primary),
              ),
              Text(".nubecat.com"),
            ],
          ),
        ],
      ),
    );
  }

  _listenOnChanged() {
    storeUrlController.addListener(() {
      if (storeUrlController.text != "") {
        slugStore = storeUrlController.text;
      } else {
        slugStore = "mitienda";
      }
      setState(() {});
    });
  }

  Widget accessData() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Column(
        children: [
          CustomTextField(
            controller: emailController,
            label: 'Correo electrónico',
            inputType: TextInputType.emailAddress,
            validator: (String text) {},
          ),
          SizedBox(
            height: 15.0,
          ),
          CustomTextField(
            controller: passwordController,
            label: 'Contraseña',
            inputType: TextInputType.visiblePassword,
            validator: (String text) {},
          ),
          SizedBox(
            height: 15.0,
          ),
        ],
      ),
    );
  }

  Widget nextButton() {
    return ElevatedButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(activeStep < 2 ? 'Siguiente' : 'Crear tienda'),
          SizedBox(width: 5),
          FaIcon(
            activeStep < 2
                ? FontAwesomeIcons.chevronRight
                : FontAwesomeIcons.check,
            size: 16,
          )
        ],
      ),
      onPressed: () {
        if (activeStep < upperBound) {
          setState(() {
            activeStep++;
          });
        } else {
          Navigator.popAndPushNamed(context, "product");
        }
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(primary),
        padding:
            MaterialStateProperty.all(EdgeInsets.only(top: 12, bottom: 12)),
        textStyle: MaterialStateProperty.all(
          TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  Widget previousButton() {
    return ElevatedButton(
      onPressed: () {
        if (activeStep > 0) {
          setState(() {
            activeStep--;
          });
        }
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
            activeStep == 0 ? textColorSecondary : accent),
        padding:
            MaterialStateProperty.all(EdgeInsets.only(top: 12, bottom: 12)),
        textStyle: MaterialStateProperty.all(
          TextStyle(fontSize: 16),
        ),
      ),
      child: Text('Anterior'),
    );
  }

  Widget header() {
    return Container(
      margin: EdgeInsets.only(right: 15, left: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              headerText(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
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
              onTap: () {
                getImageFromCamera();
              },
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
            InkWell(
              onTap: () {
                getImageFromGallery();
              },
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Text("Seleccionar desde galería"),
                    Spacer(),
                    FaIcon(FontAwesomeIcons.images, color: textColorSecondary)
                  ],
                ),
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

  Future getImageFromGallery() async {
    final XFile _image = await _picker.pickImage(source: ImageSource.gallery);
    if (_image != null) {
      _cropImage(_image);
    }
    setState(() {});
  }

  Future getImageFromCamera() async {
    final XFile _image = await _picker.pickImage(source: ImageSource.camera);
    if (_image != null) {
      _cropImage(_image);
    }
    setState(() {});
  }

  _cropImage(XFile _image) async {
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: _image.path,
      aspectRatio: CropAspectRatio(ratioX: 16, ratioY: 9),
      //aspectRatioPresets: [CropAspectRatioPreset.ratio16x9],
      androidUiSettings: AndroidUiSettings(
          activeControlsWidgetColor: primary,
          toolbarTitle: 'Ajustar imagen',
          toolbarColor: primary,
          toolbarWidgetColor: Colors.white,
          hideBottomControls: true,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: true),
      iosUiSettings: IOSUiSettings(
        minimumAspectRatio: 1.0,
      ),
    );
    if (croppedFile != null) {
      _storeImage = croppedFile;
    }
    Navigator.pop(context);
    setState(() {});
  }

  // Returns the header text based on the activeStep.
  String headerText() {
    switch (activeStep) {
      case 0:
        return 'Ingresa sus datos';

      case 1:
        return 'Ingresa datos de su tienda';

      case 2:
        return 'Ingresa datos de acceso';

      default:
        return 'Ingresa sus datos';
    }
  }
}
