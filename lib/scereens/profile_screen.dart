import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  final String userId;

  ProfileScreen({required this.userId});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  bool _isLoading = false;
  String email ='';
  String fullName='';
  String phoneNumber='';
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  bool isSameUser =true;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }



  void getUserData()async{
    _isLoading = true;

    try{
      final DocumentSnapshot userDoc =
      await FirebaseFirestore.instance.collection('users').doc(widget.userId).get();
      if (userDoc == null){
        return;
      }else{
        setState(() {
          email = userDoc.get('email');
          fullName = userDoc.get('fullName');
          phoneNumber =userDoc.get('phoneNumber');

        });
        User?user =_firebaseAuth.currentUser;
        String uid= user!.uid;
        setState(() {
          // isSameUser =true;
          isSameUser =uid==widget.userId;
        });
        print('eee $isSameUser');
      }
    }catch (e){
      //
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/app_screen');
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 30,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 70 / 2),
                child: Card(
                  child: Container(
                    color: Colors.white70,
                    height: 450,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 80,
                        ),
                        Text(
                          fullName,
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.brown,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Divider(),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15, top: 10, bottom: 5),
                          child: Text(
                            'CONTACT INFO',
                            style: TextStyle(
                              fontSize: 20,
                              color:Colors.red,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                        Text_information(
                          text: 'Email : ',
                          information: email,
                        ),
                        Text_information(
                          text: 'Phone : ',
                          information: phoneNumber,
                        ),

                      SizedBox(height: 30,),
                        isSameUser?Container():Padding(
                          padding: const EdgeInsets.only(
                              left: 40, right: 40, top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircelAvatarSocialImage(
                                imageUrl: '',
                                backColor: Colors.white,
                                color: Colors.green,
                                icon: Icon(Icons.message,size: 27,),
                                IconColor: Colors.green,
                                fct: (){
                                  openWhatsAppChat();
                                },
                              ),
                              CircelAvatarSocialImage(
                                imageUrl: '',
                                backColor: Colors.white,
                                color: Colors.red,
                                icon: Icon(Icons.email,size: 27,),
                                IconColor: Colors.red,
                                fct: (){
                                  mailTo();
                                },
                              ),
                              CircelAvatarSocialImage(
                                imageUrl: '',
                                backColor: Colors.white,
                                color: Colors.blueGrey,
                                icon: Icon(Icons.phone,size: 27,),
                                IconColor: Colors.blueGrey,
                                fct: (){
                                  callPhoneNumber();
                                },
                              ),
                            ],
                          ),
                        ),
                        isSameUser?Container(): Divider(),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 70, right: 70, top: 10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red.shade400,
                              minimumSize: Size(10, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, '/app_screen');
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Logout',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 21,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(
                                  Icons.logout,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Color(0xFFEDE8DC),
                      borderRadius: BorderRadius.circular(70),
                    ),
                    child:Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(70),
                        border: Border.all(
                          color: Colors.white,
                          width: 3,
                        ),
                        
                      ),
                      // child: Image.network(''),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  void openWhatsAppChat() async {
    String phoneNumber = '745768';
    var whatsappUrl = 'https://wa.me/$phoneNumber?text=HelloThere';
    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      throw 'Error occured coulnd\'t open link';
    }
  }



  void mailTo() async {
     String email = 'amer@gmail.com';
    var url = 'mailto:$email';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Error occured coulnd\'t open link';
    }
  }

  void callPhoneNumber() async {
    String phoneNumber = '970-3758784';
    var phoneUrl = 'tel://$phoneNumber';
    if (await canLaunch(phoneUrl)) {
      launch(phoneUrl);
    } else {
      throw "Error occured coulnd\'t open link";
    }
  }




}

class Text_information extends StatelessWidget {
  final String text;
  final String information;
  Text_information({
    required this.text,
    required this.information,
});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 10, bottom: 5),
          child:RichText(
            text: TextSpan(
              text: text,
              style:TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.black,
                fontSize: 25,
              ),
              children:[
                TextSpan(text: information,
                    style: TextStyle(
                      fontSize: 19,
                      color: Colors.brown,
                      fontWeight: FontWeight.w500,
                    )
                ),
              ],
            ),
          )
        ),
      ],
    );
  }
}

class CircelAvatarSocialImage extends StatelessWidget {
  final String imageUrl;
  final Color backColor;
  final Color color;
  final Icon icon;
  final Color IconColor;
  final Function fct;

  CircelAvatarSocialImage({
    required this.imageUrl,
    required this.backColor,
    required this.color,
    required this.icon,
    required this.IconColor,
    required this.fct,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 70,
      decoration: BoxDecoration(
        color: backColor,
        borderRadius: BorderRadius.circular(70),
        border: Border.all(
          color: color,
          width: 3,
        ),
      ),
      child: IconButton(
        onPressed: (){
          fct();
        },
        icon:icon,
        color:IconColor,
      ),
    );
  }
}



