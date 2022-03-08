import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasks_app/constanse/constanse.dart';
import 'package:tasks_app/widgets/drawer_widget.dart';
import 'package:tasks_app/widgets/text_field_in_addTask.dart';
import 'package:tasks_app/widgets/text_in_add_task.dart';

class AddTasks extends StatefulWidget {
  @override
  State<AddTasks> createState() => _AddTasksState();
}

class _AddTasksState extends State<AddTasks> {
  late TextEditingController _taskCategoryController;
  late TextEditingController _tasktitleController;
  late TextEditingController _descriptionController;

  late TextEditingController _dedLineController;
   DateTime? picked;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _taskCategoryController = TextEditingController();
    _tasktitleController = TextEditingController();
    _descriptionController = TextEditingController();
    _dedLineController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _taskCategoryController.dispose();
    _descriptionController.dispose();
    _dedLineController.dispose();
    _tasktitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Card(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    'All field are required',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade900,
                    ),
                  ),
                ),
              ),
              Divider(),
              textInAddTasks(
                text: 'Task category*',
              ),
              TextFildInAddTask(
                enabel: false,
                controller: _taskCategoryController,
                text: '${Constanse.taskCategoryList[1]}',
                fct: () {
                  showTaskCategoryDialog(context, size);
                },
                maxLength: 1,
                maxLine: 1,
              ),
              textInAddTasks(
                text: 'Task title*',
              ),
              TextFildInAddTask(
                enabel: true,
                controller: _tasktitleController,
                text: '',
                fct: () {},
                maxLength: 1,
                maxLine: 1,
              ),
              textInAddTasks(
                text: 'Task description*',
              ),
              TextFildInAddTask(
                enabel: true,
                controller: _descriptionController,
                text: '',
                fct: () {},
                maxLength: 1,
                maxLine: 4,
              ),
              textInAddTasks(
                text: 'Deadline date*',
              ),
              TextFildInAddTask(
                enabel: false,
                fct: () {
                  showDateTime();
                },
                controller: _dedLineController,
                text: 'Date',
                maxLength: 1,
                maxLine: 1,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50, right: 50, top: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red.shade400,
                    minimumSize: Size(10, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Update',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 21,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showDateTime() async {
    picked = (await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(Duration(days: 0)),
        lastDate: DateTime(2100)))!;

      if(picked != null){
        setState(() {
          _dedLineController.text = '${picked!.year}'+' - '+'${picked!.month}'+' - '+'${picked!.day}';
        });
      }
    // print('${picked}');
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
                   setState(() {
                     _taskCategoryController.text =Constanse.taskCategoryList[index];
                   });
                   Navigator.pop(context);
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
                Navigator.canPop(context) ? Navigator.pop(context) : null;
              },
              child: Text(
                'Close',
              ),
            ),
          ],
        );
      },
    );
  }
}

