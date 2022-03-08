import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasks_app/controller/fb_controller/fb_auth_controller.dart';
import 'package:tasks_app/utils/helpers.dart';
import 'package:tasks_app/widgets/text_field_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin,Helpers{
  late AnimationController _animationController;
  late Animation<double> _animation;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    // TODO: implement initState
    _emailController =TextEditingController();
    _passwordController =TextEditingController();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 20));
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.bounceIn)
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((animationStatus) {
            if (animationStatus == AnimationStatus.completed) {
              _animationController.reset();
              _animationController.forward();
            }
          });
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX:0,sigmaY: 0),
            child: CachedNetworkImage(
              imageUrl:
              "https://c0.wallpaperflare.com/preview/75/28/918/macbook-minimal-dark-wallpaper.jpg",
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              placeholder: (context, url) => Image.asset(
                'images/busines.png',
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
              alignment: FractionalOffset(_animation.value, 0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: ListView(
              children: [
                SizedBox(
                  height: 80,
                ),
                Text(
                  'LOGIN',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                InkWell(
                  onTap: (){
                    Navigator.pushReplacementNamed(context, '/register_screen');
                  },
                  child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Don\'t have an account ? ",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white60,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: "SIGN UP",
                            style: TextStyle(
                              fontSize: 19,
                              color:Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )),
                ),
                SizedBox(
                  height: 50,
                ),
                text_field_widget(
                  controller: _emailController,
                  enabel: true,
                  hintText: "Email",
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                text_field_widget(
                  controller: _passwordController,
                  enabel: true,

                  hintText: "Password",
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Spacer(),
                    InkWell(
                      onTap: (){
                        Navigator.pushReplacementNamed(context, '/forget_password');
                      },
                      child: Text(
                        ' forget password',
                        style: TextStyle(
                          fontSize: 20,
                          color:Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  // onPressed: (){},
                  onPressed: ()=>performLogin(),
                  style: ElevatedButton.styleFrom(
                    primary:Color.fromARGB(252, 135, 134, 112).withOpacity(0.6),
                    minimumSize: Size(0, 55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child:Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 25,

                        ),
                      ),
                      SizedBox(width: 10,),
                      Icon(
                        Icons.login,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> performLogin() async {
    if (checkData()) {
      await login();
    }
  }

  bool checkData() {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<void> login() async {
    bool states = await FbAuthController().signIn(
        context: context,
        email: _emailController.text,
        password: _passwordController.text
    );
    if (states) {
      Navigator.pushReplacementNamed(context, '/app_screen');
    }
  }
}

