import 'package:fabrishop/data/api/product_api.dart';
import 'package:fabrishop/data/models/category.dart';
import 'package:fabrishop/data/models/product.dart';
import 'package:fabrishop/ui/constants/colors.dart';
import 'package:fabrishop/ui/constants/shared_constants.dart';
import 'package:fabrishop/ui/constants/shared_utils.dart';
import 'package:fabrishop/ui/widgets/CustomTextField.dart';
import 'package:fabrishop/utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ProductAdd extends StatefulWidget {
  ProductAdd({Key key}) : super(key: key);

  @override
  _ProductAddState createState() => _ProductAddState();
}

class _ProductAddState extends State<ProductAdd> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();
  List<File> _fileImages = [];
  final ImagePicker _picker = ImagePicker();
  List<Category> _categories = [];
  final _productApi = ProductApi();
  bool isFetching = true;
  Category _categorySelected;

  @override
  void initState() {
    super.initState();
    _getCategories();
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
                      "Nuevo producto",
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
                            _addImageWidget(),
                            SizedBox(
                              height: 20.0,
                            ),
                            CustomTextField(
                              controller: nameController,
                              label: 'Nombre del producto',
                              inputType: TextInputType.text,
                              validator: (String text) {},
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            TextFormField(
                              controller: descriptionController,
                              keyboardType: TextInputType.multiline,
                              minLines: 5,
                              maxLines: null,
                              decoration: InputDecoration(
                                labelText: "Descripción",
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
                            Text(
                              "La descripción es opcional",
                              style: TextStyle(color: textColorSecondary),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            _categoryWidget(),
                            SizedBox(
                              height: 15.0,
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            CustomTextField(
                              label: 'Precio',
                              controller: priceController,
                              inputType: TextInputType.number,
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
                          child: Text('Agregar producto'),
                          onPressed: () {
                            _agregarProducto();
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

  Widget _addImageWidget() {
    return Row(
      children: [
        for (File image in _fileImages)
          _singleImage(image, _fileImages.indexOf(image)),
        SizedBox(width: _fileImages.length != 0 ? 10 : 0),
        InkWell(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
            _showMenu();
          },
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: textColorSecondary,
                width: 1,
              ),
              color: white,
            ),
            child: Center(
              child: FaIcon(FontAwesomeIcons.camera, color: textColorSecondary),
            ),
          ),
        )
      ],
    );
  }

  Widget _singleImage(File file, int position) {
    return Container(
      margin: EdgeInsets.only(left: 5),
      height: 100,
      width: 100,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image.file(
            File(file.path),
            fit: BoxFit.cover,
            height: 100,
            width: 100,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              height: 20,
              width: 20,
              child: FloatingActionButton(
                mini: true,
                backgroundColor: red,
                child: FaIcon(
                  FontAwesomeIcons.trash,
                  size: 10,
                ),
                onPressed: () {
                  _fileImages.removeAt(position);
                  setState(() {});
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _categoryWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isFetching
            ? CircularProgressIndicator()
            : _categories.length != 0
                ? Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: white,
                      border: Border.all(color: textColorSecondary),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 3.0, bottom: 3.0, right: 10.0, left: 10.0),
                      child: DropdownButton<Category>(
                        isExpanded: true,
                        underline: Container(),
                        onChanged: (Category newValue) {
                          setState(() {
                            print(newValue.name);
                            _categorySelected = newValue;
                          });
                        },
                        value: _categorySelected != null
                            ? _categorySelected
                            : _categories[0],
                        iconSize: 24.0,
                        items: _categories.map<DropdownMenuItem<Category>>(
                          (Category value) {
                            return DropdownMenuItem<Category>(
                              value: value,
                              child: Text(
                                value.name,
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    ),
                  )
                : ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "category_add");
                    },
                    child: Text("Agregar una categoría"),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(accent),
                      textStyle: MaterialStateProperty.all(
                        TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
        SizedBox(height: 5),
        Text(
          "Selecciona una categoría",
          style: TextStyle(color: textColorSecondary),
        )
      ],
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

  _getCategories() async {
    _categories.clear();
    _categories.add(
      Category(name: "Selecciona...", id: 0),
    );
    var _categoriesApi = await _productApi.getHome(
        store: PreferenceUtils.getInt(SharedConstants.storeId));
    _categories.addAll(_categoriesApi);
    _categorySelected = _categories[0];
    isFetching = false;
    setState(() {});
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
      aspectRatio: CropAspectRatio(ratioX: 4, ratioY: 4),
      //aspectRatioPresets: [CropAspectRatioPreset.],
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
      _fileImages.add(croppedFile);
    }
    Navigator.pop(context);
    setState(() {});
  }

  _agregarProducto() async {
    if (_fileImages.length == 0) {
      Dialogs.alert(context,
          title: "Oops!", message: "Sube una o varias imágenes del producto");
    } else if (nameController.text.length == 0) {
      Dialogs.alert(context,
          title: "Oops!", message: "Ingresa nombre del producto");
    } else if (_categorySelected.id == 0) {
      Dialogs.alert(context,
          title: "Oops!", message: "Selecciona una categoría del producto");
    } else {
      Dialogs.showLoaderDialog(context, "Publicando, espere un momento...");
      final Product prod = Product(
          name: nameController.text,
          description: descriptionController.text,
          category: _categorySelected.id,
          price: double.parse(priceController.text),
          store: PreferenceUtils.getInt(SharedConstants.storeId));
      final isOk = await _productApi.createProduct(prod, _fileImages);
      Navigator.pop(context);
      if (isOk) {
        Fluttertoast.showToast(msg: "Producto creado con éxito");
        nameController.text = "";
        descriptionController.text = "";
        priceController.text = "";
        _fileImages = [];
      } else {
        Fluttertoast.showToast(msg: "Ooops! Hubo un error. ¡Intenta de nuevo!");
      }
      setState(() {});
    }
  }
}
