import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasks_app/scereens/detail_screen.dart';
import 'package:tasks_app/utils/helpers.dart';
class tasks_widgets extends StatelessWidget with Helpers{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final String title;
  final String subTitle;


  // final String createAt;
  final String taskId;
  final String taskCategory;
  // final Timestamp.now() deadLineDate;
  final String uploadedBy;
  final bool isDone;

  tasks_widgets({
    required this.title,
    required this.subTitle,
    // required this.createAt,
    // required this.deadLineDate,
    required this.taskCategory,
    required this.taskId,
    required this.uploadedBy,
    required this.isDone,
    });
  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 8,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: ListTile(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return DetailScreen(
              taskId: taskId,
              uploadBy: uploadedBy,
            );
          },));
        },
        onLongPress: () {
          showDialog(context: context, builder: (context) {
            return AlertDialog(
              actions: [
                TextButton(
                  onPressed: (){
                    User?user =_firebaseAuth.currentUser;
                    String uid= user!.uid;
                    if(uid ==uploadedBy){
                    FirebaseFirestore.instance.collection('tasks')
                        .doc(taskId)
                        .delete();
                    showSnackBar(context: context, message: 'task deleted successfully',error: false);
                    Navigator.pop(context);
                    }else{
                      showSnackBar(context: context, message: 'You can\'t delete this task',error: true);
                      Navigator.pop(context);
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    SizedBox(width: 10,),
                    Text('Delete',style: TextStyle(color: Colors.red),),
                  ],
                  ),
                ),
              ],
            );
          },);
        },
        contentPadding:
        EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: Container(
          padding: EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(width: 1),
            ),
          ),
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 20,
            //https://image.flaticon.com/icons/png/128/850/850960.png
            child: Image.network(
             isDone?
             'https://image.flaticon.com/icons/png/128/850/850960.png':
                'https://image.flaticon.com/icons/png/128/390/390973.png',

            ),
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 19,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.linear_scale,
              color: Colors.red,
            ),
            Text(
              subTitle,
              style: TextStyle(
                fontSize: 16,

              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        trailing:IconButton(
          onPressed: (){},
          icon: Icon(
            Icons.keyboard_arrow_right,
            size: 30,
            color: Colors.red,
          ),
        ),
      ),

    );
  }
}
