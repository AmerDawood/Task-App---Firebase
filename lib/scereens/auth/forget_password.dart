import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tasks_app/utils/helpers.dart';
import 'package:tasks_app/widgets/text_field_widget.dart';

import '../../controller/fb_controller/fb_auth_controller.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword>
    with TickerProviderStateMixin ,Helpers{
  late AnimationController _animationController;
  late Animation<double> _animation;
  late TextEditingController _emailController;


  @override
  void initState() {
    // TODO: implement initState
    _emailController = TextEditingController();
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
    _animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CachedNetworkImage(
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

          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: ListView(
              children: [
                SizedBox(
                  height: 80,
                ),
                Text(
                  'FORGET PASSWORD',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: "Email address",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white60,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )),
                SizedBox(
                  height: 10,
                ),
                text_field_widget(
                  controller:_emailController,
                  enabel: true,
                  hintText: "Email",
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: ()async =>await performReset(),
                  style: ElevatedButton.styleFrom(
                    primary:Color.fromARGB(252, 135, 134, 112).withOpacity(0.6),
                    minimumSize: Size(0, 55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child:  Text(
                    'Reset Password',
                    style: TextStyle(
                      fontSize: 25,

                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }



  Future<void> performReset() async {
    if (checkData()) {
      await resetPassword();
    }
  }

  bool checkData() {
    if (_emailController.text.isNotEmpty
        ) {
      return true;
    }
    return false;
  }

  Future<void> resetPassword() async {
    bool states = await FbAuthController().resetPassword(
      context: context,
      email: _emailController.text,
    );
    if (states) {
      Navigator.pushReplacementNamed(context, '/login_screen');
    }
  }

}
