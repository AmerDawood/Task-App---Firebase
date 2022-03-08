import 'package:flutter/material.dart';

import '../scereens/profile_screen.dart';
class WorkerWidget extends StatefulWidget {

   //
   // final String name;
   // final String date;
   // WorkerWidget({
   //   required this.name,
   //   required this.date,
   //       });

 final String userID;
 final String userName;
 final String userEmail;
 // final DateTime dateOfCreate;
 final String phoneNumber;
 final String job;
 WorkerWidget({
  required this.phoneNumber,
  // required this.dateOfCreate,
  required this.userEmail,
  required this.userID,
  required this.userName,
   required this.job,
       });

  @override
  State<WorkerWidget> createState() => _WorkerWidgetState();
}

class _WorkerWidgetState extends State<WorkerWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfileScreen(
                userId:widget.userID,
              ),
            ),
          );
        },
        onLongPress: () {
          showDialog(context: context, builder: (context) {
            return AlertDialog(
              actions: [
                TextButton(
                  onPressed: (){},
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
            child: Image.network('https://image.flaticon.com/icons/png/128/390/390973.png'),
          ),
        ),
        title: Text(
          widget.userName,
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
              widget.job,
              style: TextStyle(
                fontSize: 16,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        trailing:Icon(
          Icons.email_outlined,
          size: 30,
          color: Colors.red,
        ),
      ),
    );
  }
}
