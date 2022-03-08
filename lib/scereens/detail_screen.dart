import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasks_app/widgets/comments_widgets.dart';
class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool _isCommenting = false;
  late TextEditingController _commentController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _commentController =TextEditingController();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFEDE7DC),
        elevation: 0,
        leading: IconButton(
          onPressed: (){
            Navigator.pushReplacementNamed(context, '/app_screen');
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 30,
          ),
        ),
      ),
      body:ListView(
        children: [
          Center(
            child: Text('Develop an App',
            style: TextStyle(
              fontSize: 30,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20,top: 10),
            child: Container(
              color: Colors.white,
              width: 100,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30,left: 16),
                    child: Row(
                      children: [
                        Text('Developed by',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child:Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: Colors.red,width: 3)
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 6,right: 7),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Amer Dawood',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text('Dev',
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.only(top: 30,left: 16),
                    child: Row(
                      children: [
                        Text('Uploaded in',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Text('2022/3/3',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.blueGrey.shade400,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20,left: 16,bottom: 15),
                    child: Row(
                      children: [
                        Text('Deadline in',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Text('2022/3/7',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.blueGrey.shade400,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Still have time',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.only(top: 20,left: 16,bottom: 15),
                    child: Row(
                      children: [
                        Text('Done stats',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),


                      ],
                    ),
                  ),

                  Divider(),
                  Padding(
                    padding: const EdgeInsets.only(top: 20,left: 16,bottom: 15),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text('Task Description',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),


                          ],
                        ),
                        Align(
                          alignment: AlignmentDirectional.topStart,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Description',
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Divider(),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 50, right: 50, top: 10),
                  //   child: ElevatedButton(
                  //     style: ElevatedButton.styleFrom(
                  //       primary: Colors.red.shade400,
                  //       minimumSize: Size(10, 50),
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(20),
                  //       ),
                  //     ),
                  //     onPressed: () {},
                  //     child: Text(
                  //       'Add comments',
                  //       style: TextStyle(
                  //         fontWeight: FontWeight.bold,
                  //         fontSize: 21,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 500),
                    child: _isCommenting
                        ? Row(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      mainAxisAlignment:
                      MainAxisAlignment.spaceAround,
                      children: [
                        Flexible(
                          flex: 3,
                          child: TextField(
                            maxLength: 200,
                            controller: _commentController,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            keyboardType: TextInputType.text,
                            maxLines: 6,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Theme.of(context)
                                  .scaffoldBackgroundColor,
                              enabledBorder:
                              UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white),
                              ),
                              errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.red),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.pink),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                            flex: 1,
                            child: Padding(
                              padding:
                              const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                children: [
                                  MaterialButton(
                                    onPressed: () async {
                                      if (_commentController
                                          .text.length <
                                          7) {
                                        // GlobalMethods
                                        //     .showErrorDialog(
                                        //     error:
                                        //     'Comment cant be less than 7 characteres',
                                        //     context:
                                        //     context);
                                      } else {
                                        // final _generatedId =
                                        // Uuid().v4();
                                        // await FirebaseFirestore
                                        //     .instance
                                        //     .collection('tasks')
                                        //     .doc(widget.taskId)
                                        //     .update({
                                        //   'taskComments':
                                        //   FieldValue
                                        //       .arrayUnion([
                                        //     {
                                        //       'userId': widget
                                        //           .uploadedBy,
                                        //       'commentId':
                                        //       _generatedId,
                                        //       'name':
                                        //       _authorName,
                                        //       'commentBody':
                                        //       _commentController
                                        //           .text,
                                        //       'time': Timestamp
                                        //           .now(),
                                        //       'userImageUrl':
                                        //       userImageUrl,
                                        //     }
                                        //   ]),
                                        // });
                                        // await Fluttertoast.showToast(
                                        //     msg:
                                        //     "Task has been uploaded successfuly",
                                        //     toastLength: Toast
                                        //         .LENGTH_LONG,
                                        //     gravity:
                                        //     ToastGravity
                                        //         .CENTER,
                                        //     fontSize: 16.0);
                                        _commentController
                                            .clear();
                                        setState(() {});
                                      }
                                    },
                                    color: Colors.pink.shade700,
                                    elevation: 10,
                                    shape:
                                    RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius
                                            .circular(
                                            13),
                                        side: BorderSide
                                            .none),
                                    child: Padding(
                                      padding: const EdgeInsets
                                          .symmetric(
                                          vertical: 14),
                                      child: Text(
                                        'Post',
                                        style: TextStyle(
                                            color: Colors.white,
                                            // fontSize: 20,
                                            fontWeight:
                                            FontWeight
                                                .bold),
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        setState(() {
                                          _isCommenting =
                                          !_isCommenting;
                                        });
                                      },
                                      child: Text('Cancel')),
                                ],
                              ),
                            ))
                      ],
                    )
                        : Center(
                      child: MaterialButton(
                        onPressed: () {
                          setState(() {
                            _isCommenting = !_isCommenting;
                          });
                        },
                        color: Colors.pink.shade700,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(13),
                            side: BorderSide.none),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 14),
                          child: Text(
                            'Add a comment',
                            style: TextStyle(
                                color: Colors.white,
                                // fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),


                  SizedBox(height: 7,),
                  Divider(),
                  commentsWidgets(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

