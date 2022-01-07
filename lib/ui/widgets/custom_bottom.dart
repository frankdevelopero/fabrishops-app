import 'package:fabrishop/ui/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomBottom extends StatefulWidget {
  final int index;
  CustomBottom({Key key, this.index}) : super(key: key);

  @override
  _CustomBottomState createState() => _CustomBottomState();
}

class _CustomBottomState extends State<CustomBottom> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: primary,
      onTap: (int index) {
        setState(() {
          if (index == 0) {
            Navigator.popAndPushNamed(context, "product");
          } else if (index == 1) {
            Navigator.popAndPushNamed(context, "order");
          } else if (index == 2) {
            Navigator.popAndPushNamed(context, "store");
          } else if (index == 3) {
            Navigator.popAndPushNamed(context, "setting");
          }
        });
      },
      currentIndex: widget.index,
      items: [
        BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.sitemap), label: "Catálogo"),
        BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.book), label: "Pedidos"),
        BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.store), label: "Mi tienda"),
        BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.cog), label: "Ajustes"),
      ],
    );
  }
}
