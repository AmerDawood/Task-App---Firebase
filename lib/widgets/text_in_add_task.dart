import 'package:flutter/material.dart';
class textInAddTasks extends StatelessWidget {
  final String text;
  textInAddTasks({
    required this.text,
});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: AlignmentDirectional.topStart,
        child: Text(text,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
