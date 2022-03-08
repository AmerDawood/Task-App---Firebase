import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:tasks_app/constanse/constanse.dart';
import 'package:tasks_app/utils/helpers.dart';
import 'package:tasks_app/widgets/text_field_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with TickerProviderStateMixin,Helpers{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  late AnimationController _animationController;
  late Animation<double> _animation;
  late TextEditingController _jobsList;

  late TextEditingController _fullNameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _phoneNumberController;

  File? imageFile;

  @override
  void initState() {
    // TODO: implement initState

    _fullNameController =TextEditingController();
    _emailController =TextEditingController();
    _passwordController =TextEditingController();
    _phoneNumberController =TextEditingController();
    _jobsList = TextEditingController();
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
    _animationController.dispose();
    _jobsList.dispose();
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
            errorWidget: (context, url, error) => const Icon(Icons.error),
            alignment: FractionalOffset(_animation.value, 0),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: ListView(
              children: [
                const SizedBox(
                  height: 80,
                ),
                const Text(
                  'SIGN UP',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/login_screen');
                  },
                  child: RichText(
                      text: const TextSpan(
                    children: [
                      TextSpan(
                        text: "Already have an account ? ",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white60,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: "LOGIN",
                        style: TextStyle(
                          fontSize: 19,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )),
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: text_field_widget(
                        controller: _fullNameController,
                        enabel: true,
                        hintText: "Full Name",
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Stack(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, right: 10),
                              child: Container(
                                width: 110,
                                height: 90,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                // child: Image.network(
                                //   'https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png',
                                //   fit: BoxFit.cover,
                                // ),
                                // clipBehavior: Clip.antiAlias,
                                child: imageFile == null
                                    ? Image.network(
                                        'https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png',
                                        fit: BoxFit.cover,
                                      )
                                    : Image.file(
                                        imageFile!,
                                        fit: BoxFit.fill,
                                      ),
                                clipBehavior: Clip.antiAlias,
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: InkWell(
                                onTap: () {
                                  showImageDialog();
                                },
                                child: Container(
                                  width: 37,
                                  height: 37,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 2,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.add_a_photo,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                text_field_widget(
                  controller: _emailController,
                  enabel: true,
                  hintText: "Email",
                  prefixIcon: const Icon(
                    Icons.email,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                text_field_widget(
                  controller: _passwordController,
                  enabel: true,
                  hintText: "Password",
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                text_field_widget(
                  controller: _phoneNumberController,
                  enabel: true,
                  hintText: "Phone number",
                  prefixIcon: const Icon(
                    Icons.phone,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                text_field_widget(
                  controller: _passwordController,
                  enabel: true,
                  hintText: "Confirm Password",
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InkWell(
                      onTap: () {
                        showJobDialog(context, size);
                      },
                      child: TextField(
                        enabled: false,
                        controller: _jobsList,
                        // maxLength: maxLength,
                        // maxLines: maxLine,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white24,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.transparent,
                            ),
                          ),
                          hintText: 'Choice your jop',
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(


                  onPressed: () => performRegister(),
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(252, 135, 134, 112)
                        .withOpacity(0.6),
                    minimumSize: const Size(0, 55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
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

  void pickImageWithCamera() async {
    PickedFile? pickedFile = await ImagePicker()
        .getImage(source: ImageSource.camera, maxWidth: 1080, maxHeight: 1080);
    // setState(() {
    //   imageFile = File(pickedFile!.path);
    // });
    cropImage(pickedFile!.path);
    Navigator.pop(context);
  }

  void pickImageWithGallary() async {
    PickedFile? pickedFile = await ImagePicker()
        .getImage(source: ImageSource.gallery, maxWidth: 1080, maxHeight: 1080);
    // setState(() {
    //   imageFile = File(pickedFile!.path);
    // });
    cropImage(pickedFile!.path);
    Navigator.pop(context);

  }



  void cropImage(filePath) async {
    File? cropImage = await ImageCropper().cropImage(
      sourcePath: filePath,
      maxHeight: 1080,
      maxWidth: 1080,
    );
    if(cropImage != null){
     setState(() {
       imageFile =cropImage;
     });
    }
  }


  void showImageDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: Text(
              'Pleas choice an option',
              style: TextStyle(
                fontSize: 25,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Divider(),
                InkWell(
                  onTap: () {
                    pickImageWithCamera();
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.camera,
                        color: Colors.black,
                      ),
                      Text(
                        ' Camera',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    pickImageWithGallary();
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.image,
                        color: Colors.black,
                      ),
                      Text(
                        ' Gallary',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ));
      },
    );
  }

  void showJobDialog(context, size) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Tasks Category',
            style: TextStyle(
              color: Colors.red,
              fontSize: 20,
            ),
          ),
          content: Container(
            width: size.width * 0.9,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: Constanse.jobsList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      // _taskCategoryController.text =Constanse.taskCategoryList[index];
                    });
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        color: Colors.red,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          Constanse.jobsList[index],
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
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.canPop(context) ? Navigator.pop(context) : null;
              },
              child: Text(
                'Close',
              ),
            ),
          ],
        );
      },
    );
  }
  Future<void> performRegister() async {
    if (checkData()) {
      await createAccount(
        context: context,
        email: _emailController.text,
        password: _passwordController.text,
        fullName: _fullNameController.text,
        phoneNumber: _phoneNumberController.text,
      );
    }
  }


  bool checkData() {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty&&
        _fullNameController.text.isNotEmpty&&
        _phoneNumberController.text.isNotEmpty
    ) {
      Navigator.pushReplacementNamed(context, '/login_screen');
      return true;
    }
    showSnackBar(context: context, message: 'Enter required data',error: true);
    return false;
  }

  Future<bool> createAccount(
      {required BuildContext context,
        required String email,
        required String password,
        required String fullName,
        required String phoneNumber
      }) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      final User? user =  _firebaseAuth.currentUser;
      final uid= user!.uid;
      FirebaseFirestore.instance.collection('users').doc(uid).set(
        {
          'id':uid,
          'email':_emailController.text,
          'fullName':_fullNameController.text,
          'phoneNumber':_phoneNumberController.text,
          'createAt':Timestamp.now(),
        },
      );
      userCredential.user?.sendEmailVerification();
      return true;
    } on FirebaseAuthException catch (e) {
      _controlException(context, e);
    } catch (e) {
      //
    }
    return false;
  }
  void _controlException(
      BuildContext context, FirebaseAuthException exception) {
    showSnackBar(
        context: context,
        message: exception.message ?? 'ERROR !!',
        error: true);
    switch (exception.code) {
      case 'invalid-email':
        break;
      case 'user-disabled':
        break;
      case 'user-not-found':
        break;
      case 'wrong-password':
        break;
    }
  }


}
