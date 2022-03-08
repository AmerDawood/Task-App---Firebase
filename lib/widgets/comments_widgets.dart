import 'package:flutter/material.dart';
class commentsWidgets extends StatelessWidget {
  List <Color> color =[
    Colors.green,
    Colors.orange,
    Colors.blue,
    Colors.yellow,
    Colors.red,
    Colors.deepPurple
  ];

  @override
  Widget build(BuildContext context) {
    color.shuffle();
    return SizedBox(
      height: 500,
      child: ListView.builder(
        itemCount: 5,
        itemBuilder:(context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              leading:Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xff7c94b6),
                  image: const DecorationImage(
                    image: NetworkImage(''),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: const BorderRadius.all( Radius.circular(50.0)),
                  border: Border.all(
                    color:color[index],
                    width: 4,
                  ),
                ),
              ),
              title: Text('Amer Dawood',style:TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),
              subtitle: Text('This ia a task',style:TextStyle(fontSize: 15,color: Colors.grey,fontWeight: FontWeight.bold),),
            ),
          );
        },),
    );
  }
}
