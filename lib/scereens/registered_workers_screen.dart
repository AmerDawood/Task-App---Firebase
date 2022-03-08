import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
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
        title: Text(
          'All worker',
          style: TextStyle(
              fontSize: 22, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data!.docs.isNotEmpty) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return WorkerWidget(
                    job: snapshot.data!.docs[index]['job'],
                    userID: snapshot.data!.docs[index]['id'],
                    // dateOfCreate: snapshot.data!.docs[index]['createAt'],
                    phoneNumber: snapshot.data!.docs[index]['phoneNumber'],
                    userEmail: snapshot.data!.docs[index]['email'],
                    userName: snapshot.data!.docs[index]['fullName'],
                  );
                },
              );
            } else {
              return Center(
                child: Text('No users found'),
              );
            }
          }
          return Center(
            child: Text('Something went wrong'),
          );
        },
      ),
    );
  }
}
