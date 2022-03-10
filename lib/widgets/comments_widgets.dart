import 'package:flutter/material.dart';

import '../scereens/profile_screen.dart';
class commentsWidgets extends StatelessWidget {
  List <Color> color =[
    Colors.green,
    Colors.orange,
    Colors.blue,
    Colors.yellow,
    Colors.red,
    Colors.deepPurple
  ];

  final String name;
  final String description;
  final String userId;
  final String commentId;
  commentsWidgets({
    required this.userId,
    required this.description,
    required this.name,
    required this.commentId,
});


  @override
  // Widget build(BuildContext context) {
  //   color.shuffle();
  //   return SizedBox(
  //     height: 500,
  //     child: ListView.builder(
  //       itemCount: 1,
  //       itemBuilder:(context, index) {
  //         return Padding(
  //           padding: const EdgeInsets.only(bottom: 10),
  //           child: ListTile(
  //             leading:Container(
  //               width: 50,
  //               height: 50,
  //               decoration: BoxDecoration(
  //                 color: const Color(0xff7c94b6),
  //                 image: const DecorationImage(
  //                   image: NetworkImage(''),
  //                   fit: BoxFit.cover,
  //                 ),
  //                 borderRadius: const BorderRadius.all( Radius.circular(50.0)),
  //                 border: Border.all(
  //                   color:color[index],
  //                   width: 4,
  //                 ),
  //               ),
  //             ),
  //             title: Text(name,style:TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),
  //             subtitle: Text(description,style:TextStyle(fontSize: 15,color: Colors.grey,fontWeight: FontWeight.bold),),
  //           ),
  //         );
  //       },),
  //   );
  // }
  Widget build(BuildContext context) {
    color.shuffle();
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileScreen(
              userId : commentId,
            ),
          ),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 5,
          ),
          Flexible(
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: color[3],
                ),
                shape: BoxShape.circle,
                // image: DecorationImage(
                //     image: NetworkImage(
                //       commenterImageUrl,
                //     ),
                //     fit: BoxFit.fill),
              ),
            ),
          ),
          Flexible(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    description,
                    style: TextStyle(
                        fontStyle: FontStyle.italic, color: Colors.grey.shade700),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
