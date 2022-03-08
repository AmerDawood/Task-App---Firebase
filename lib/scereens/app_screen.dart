import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tasks_app/constanse/constanse.dart';
import 'package:tasks_app/widgets/drawer_widget.dart';
import 'package:tasks_app/widgets/tasks_widgets.dart';

class AppScreen extends StatelessWidget {


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
              return
                IconButton(
                  onPressed: (){
                    Scaffold.of(context).openDrawer();
                  },
                  icon: Icon(Icons.menu,color: Colors.black,),
                );
            },

          ),
          actions: [
            IconButton(
              onPressed: () {

                showTaskCategoryDialog(context,size);
              },
              icon: Icon(
                Icons.filter_list_outlined,
                color: Colors.black,
              ),
            ),
          ],
        ),

        body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return tasks_widgets();
          },
        ));
  }

  void showTaskCategoryDialog(context,size){
    showDialog(
      context: context,
      builder:(context) {
        return AlertDialog(
          title: Text('Tasks Category',
            style: TextStyle(
              color: Colors.red,
              fontSize: 20,
            ),

          ),
          content: Container(
            width: size.width*0.9,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount:Constanse.taskCategoryList.length,
              itemBuilder:(context, index) {
                return InkWell(
                  onTap: (){
                    print('${Constanse.taskCategoryList[index]}');
                  },
                  child: Row(
                    children: [
                      Icon(Icons.check_circle_outline,color: Colors.red,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(Constanse.taskCategoryList[index],
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
              },),
          ),
          actions: [
            TextButton(onPressed: (){
              Navigator.canPop(context) ? Navigator.pop(context):null;
            }, child:Text('Close',),),
            TextButton(onPressed: (){
            }, child:Text('Cancel Filter',),),

          ],
        );
      },);
  }
}


