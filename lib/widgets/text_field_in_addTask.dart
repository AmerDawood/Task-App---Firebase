import 'package:flutter/material.dart';
class TextFildInAddTask extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final Function fct;
  final int maxLength;
  final int maxLine;
  final bool enabel;

  TextFildInAddTask({
    required this.text,
    required this.controller,
    required this.fct,
    required this.maxLength,
    required this.maxLine,
    required this.enabel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
          onTap: () {
            fct();
          },
          child: TextField(
            enabled: enabel,
            controller: controller,
            maxLength: maxLength,
            maxLines: maxLine,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              filled: true,
              fillColor: Color(0xFFEDE7DC),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: Colors.transparent,
                ),
              ),
              hintText: text,
              hintStyle: TextStyle(
                color: Colors.blue.shade900,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
