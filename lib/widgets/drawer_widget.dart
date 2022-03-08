import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tasks_app/controller/fb_controller/fb_auth_controller.dart';

import '../scereens/profile_screen.dart';
import 'listTile_widget.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final User? user =_firebaseAuth.currentUser;
    final uid =user!.uid;
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(252, 135, 134, 112).withOpacity(0.6),
    ),
              child: Column(
                children: [
                  Flexible(
                      child: Image.network(
                          'https://d57439wlqx3vo.cloudfront.net/iblock/09d/09d5f5dd6afa66f271dc31b2bfa7e69c/b07a492ab78550e31df066577f2a204c.jpg')),
                  SizedBox(
                    height: 10,
                  ),
                  Flexible(
                      child: Text(
                    'Tasks App',
                    style: TextStyle(
                      color: Colors.blue.shade900,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 30,
                    ),
                  ),),
                ],
              )),

          listTileWidget( fct: (){
            Navigator.pushReplacementNamed(context, '/app_screen');
          },text: 'All tasks',icon: Icon(Icons.note_add,color: Colors.black,),),
          listTileWidget(

            fct: () {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder:(context) {
                  return ProfileScreen(userId:uid);
                },));},
            text: 'My account',icon: Icon(Icons.person,color: Colors.black,),),
          listTileWidget( fct: (){
            Navigator.pushReplacementNamed(context, '/registered_worker_screen');

          },text: 'Registered workers',icon: Icon(Icons.category_outlined,color: Colors.black,),),
          listTileWidget( fct: (){
            Navigator.pushReplacementNamed(context, '/add_tasks_screen');
          },text: 'Add tasks',icon: Icon(Icons.my_library_add_rounded,color: Colors.black,),),
         Divider(color: Colors.grey,height: 2,thickness: 2,endIndent: 10,indent: 10,),
          listTileWidget(
            fct: (){
            logout(context);
            },
            text: 'Logout',icon: Icon(Icons.logout,color: Colors.black,),),

        ],
      ),
    );
  }
     void logout(context){
      showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Image.network('https://image.flaticon.com/icons/png/128/1252/1252006.png',
              height: 20,
                width: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Sign out',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
              ),
            ],
          ),
          content: Text(
            'Do you want to sign out',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
          actions: [
            TextButton(onPressed: (){
              Navigator.canPop(context) ? Navigator.pop(context):null;
            }, child:Text('Close',style: TextStyle(color: Colors.blue),),),
            TextButton(
        // onPressed: () async{
        // await FbAuthController().signOut();
        // Navigator.pushReplacementNamed(context, '/login_screen');
        // },
              onPressed: (){},
              child:Text('Ok',style: TextStyle(color: Colors.red),),),

          ],
        );
      },);
     }
}
