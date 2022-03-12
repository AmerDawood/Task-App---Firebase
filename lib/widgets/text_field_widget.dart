import 'package:flutter/material.dart';
class text_field_widget extends StatelessWidget {
  final String hintText;
  final Icon prefixIcon;
  final bool enabel;
  final TextEditingController controller;
  text_field_widget({
    required this.hintText,
    required this.prefixIcon,
    required this.enabel,
    required this.controller,
});

  @override
  Widget build(BuildContext context){
    return TextField(
      enabled:enabel,
      controller: controller,
      // keyboardType:TextInputType.emailAddress,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 23,
      ),
      decoration: InputDecoration(

        enabledBorder: OutlineInputBorder(


          borderSide: BorderSide(
            width: 2,
            color: Colors.white,

          ),

          borderRadius: BorderRadius.circular(10),
        ),
        hintText: hintText,


        hintStyle: TextStyle(
          color: Colors.white70,
          fontSize: 20,
        ),
        prefixIcon:prefixIcon,
        labelStyle: TextStyle(
          fontSize: 20,
          color: Colors.white38,
        ),
        focusedBorder: OutlineInputBorder(

          borderSide: BorderSide(
            width: 1,
            color: Colors.white38,
          ),

          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
