import 'package:fabrishop/data/api/category_api.dart';
import 'package:fabrishop/data/models/category.dart';
import 'package:fabrishop/ui/constants/colors.dart';
import 'package:fabrishop/ui/constants/shared_constants.dart';
import 'package:fabrishop/ui/constants/shared_utils.dart';
import 'package:fabrishop/ui/widgets/CustomTextField.dart';
import 'package:fabrishop/utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CategoryAdd extends StatefulWidget {
  CategoryAdd({Key key}) : super(key: key);

  @override
  _CategoryAddState createState() => _CategoryAddState();
}

class _CategoryAddState extends State<CategoryAdd> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  final _categoryApi = CategoryApi();
  bool isFetching = true;

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
                      "Nueva categoría",
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
                      Form(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            CustomTextField(
                              controller: nameController,
                              label: 'Nombre',
                              inputType: TextInputType.text,
                              validator: (String text) {},
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            TextFormField(
                              controller: descriptionController,
                              keyboardType: TextInputType.multiline,
                              minLines: 5,
                              maxLines: null,
                              decoration: InputDecoration(
                                labelText: "Una breve descripción",
                                alignLabelWithHint: true,
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: primary, width: 1),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: textColorSecondary, width: 1),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text("La descripción es opcional",
                                style: TextStyle(color: textColorSecondary)),
                            SizedBox(
                              height: 15.0,
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
                          child: Text('Agregar categoría'),
                          onPressed: () {
                            _addCategory();
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

  _addCategory() async {
    if (nameController.text.length == 0) {
      Dialogs.alert(context,
          title: "Oops!", message: "Ingresa nombre de la categoría");
    } else {
      Dialogs.showLoaderDialog(context, "Espere un momento...");
      final category = Category(
          name: nameController.text, description: descriptionController.text);
      final isOk = await _categoryApi.createCategory(
        category,
        PreferenceUtils.getInt(SharedConstants.storeId),
      );
      Navigator.pop(context);
      if (isOk) {
        Fluttertoast.showToast(msg: "Categoría agregado con éxito");
        nameController.text = "";
        descriptionController.text = "";
      } else {
        Fluttertoast.showToast(msg: "Ooops! Hubo un error. ¡Intenta de nuevo!");
      }
      setState(() {});
    }
  }
}
