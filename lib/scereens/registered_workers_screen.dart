import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tasks_app/widgets/drawer_widget.dart';
import 'package:tasks_app/widgets/worker_widgets.dart';
class RegisteredWorkerScreen extends StatelessWidget {
  const RegisteredWorkerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text('All worker',style: TextStyle(fontSize: 22,color: Colors.black,fontWeight: FontWeight.bold),),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return WorkerWidget();
        },
      ),
    );

  }
}

