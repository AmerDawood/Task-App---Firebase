import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tasks_app/constanse/constanse.dart';
import 'package:tasks_app/widgets/drawer_widget.dart';
import 'package:tasks_app/widgets/tasks_widgets.dart';

class AppScreen extends StatefulWidget {
  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
 String? taskCategory;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'Tasks',
          style: TextStyle(color: Colors.black, fontSize: 27),
        ),
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(
                Icons.menu,
                color: Colors.black,
              ),
            );
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              showTaskCategoryDialog(context, size);
            },
            icon: Icon(
              Icons.filter_list_outlined,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('tasks')
            .where('taskCategory',isEqualTo: taskCategory)
        .orderBy('createdAt',descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data!.docs.isNotEmpty) {
              return ListView.builder(
                itemCount:snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return tasks_widgets(
                    title:snapshot.data!.docs[index]['taskTitle'],
                    subTitle:snapshot.data!.docs[index]['taskDescription'],
                    // createAt:snapshot.data!.docs[index]['createdAt'],
                    // deadLineDate:snapshot.data!.docs[index]['deadLineDate'],
                    taskCategory:snapshot.data!.docs[index]['taskCategory'],
                    taskId:snapshot.data!.docs[index]['taskId'],
                    uploadedBy:snapshot.data!.docs[index]['uploadedBy'],
                    isDone:snapshot.data!.docs[index]['isDone'],
                  );
                },
              );
            } else {
              return Center(
                child: Text('No tasks found'),
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

  void showTaskCategoryDialog(context, size) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Tasks Category',
            style: TextStyle(
              color: Colors.red,
              fontSize: 20,
            ),
          ),
          content: Container(
            width: size.width * 0.9,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: Constanse.taskCategoryList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    print('${Constanse.taskCategoryList[index]}');
                    setState(() {
                      taskCategory=Constanse.taskCategoryList[index];
                    });
                    Navigator.canPop(context)
                        ? Navigator.pop(context)
                        : null;
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        color: Colors.red,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          Constanse.taskCategoryList[index],
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.blue.shade900,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  taskCategory = null;
                });
                Navigator.canPop(context) ? Navigator.pop(context) : null;              },
              child: Text(
                'Close',
              ),
            ),
            TextButton(
              onPressed: () {
             setState(() {
               Navigator.canPop(context) ? Navigator.pop(context) : null;
             });
              },
              child: Text(
                'Cancel Filter',
              ),
            ),
          ],
        );
      },
    );
  }
}
