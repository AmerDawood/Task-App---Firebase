import 'package:flutter/material.dart';

class listTileWidget extends StatelessWidget {
 final String text;
 final Icon icon;
 final Function fct;
 listTileWidget({
   required this.text,
   required this.icon,
   required this.fct,
});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){
        fct();
      },
      leading: icon,
      title: Text(
        text,
        style: TextStyle(
          fontSize: 20,
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}
