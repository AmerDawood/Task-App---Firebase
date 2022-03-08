import 'package:flutter/material.dart';
class WorkerWidget extends StatelessWidget {
  const WorkerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: ListTile(
        onTap: () {},
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
          'Amer Dawood',
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
              'Monday 22/1/2002',
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
