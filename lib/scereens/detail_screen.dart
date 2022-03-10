import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasks_app/utils/helpers.dart';
import 'package:tasks_app/widgets/comments_widgets.dart';
import 'package:uuid/uuid.dart';

class DetailScreen extends StatefulWidget {
  final String taskId;
  final String uploadBy;

  DetailScreen({
    required this.taskId,
    required this.uploadBy,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> with Helpers {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? authorName;
  String? authorPosition;
  String? taskDescription;
  String? taskTitle;
  bool? isDone;
  Timestamp? postedDateTimeStamp;
  Timestamp? deadlineDateTimeStamp;
  String? deadlineDate;
  String? postedDate;
  late TextEditingController _commentController;

  // String? userImageUrl;
  bool isDeadlineAvailable = false;

  void getData() async {
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.uploadBy)
        .get();
    if (userDoc == null) {
      return;
    } else {
      setState(() {
        authorName = userDoc.get('fullName');
        authorPosition = userDoc.get('job');
        // userImageUrl = userDoc.get('userImageUrl');
      });
    }
    final DocumentSnapshot taskDoc = await FirebaseFirestore.instance
        .collection('tasks')
        .doc(widget.taskId)
        .get();
    if (taskDoc == null) {
      return;
    } else {
      setState(() {
        taskTitle = taskDoc.get('taskTitle');
        taskDescription = taskDoc.get('taskDescription');
        isDone = taskDoc.get('isDone');
        deadlineDate = taskDoc.get('deadlineDate');
        deadlineDateTimeStamp = taskDoc.get('deadlineDateTimeStamp');
        postedDateTimeStamp = taskDoc.get('createdAt');
        var postDate = postedDateTimeStamp!.toDate();
        postedDate = '${postDate.year}-${postDate.month}-${postDate.day}';
        var date = deadlineDateTimeStamp!.toDate();
        isDeadlineAvailable = date.isAfter(DateTime.now());
      });
    }
  }

  bool _isCommenting = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _commentController = TextEditingController();
    getData();
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
      body: ListView(
        children: [
          Center(
            child: Text(
              taskTitle == null ? 'Task Title' : taskTitle!,
              style: TextStyle(
                fontSize: 30,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Container(
              color: Colors.white,
              width: 100,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30, left: 16),
                    child: Row(
                      children: [
                        Text(
                          'Developed by',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        // Padding(
                        //   padding: const EdgeInsets.all(3.0),
                        //   child: Container(
                        //     width: 60,
                        //     height: 60,
                        //     decoration: BoxDecoration(
                        //         color: Colors.white,
                        //         borderRadius: BorderRadius.circular(50),
                        //         border:
                        //             Border.all(color: Colors.red, width: 3)),
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(left: 6, right: 7),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                authorName == null ? 'Name' : authorName!,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                authorPosition == null
                                    ? 'JOB'
                                    : authorPosition!,
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
                    padding: const EdgeInsets.only(top: 30, left: 16),
                    child: Row(
                      children: [
                        Text(
                          'Uploaded in',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Text(
                            postedDate == null ? 'posted Date' : postedDate!,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 16, bottom: 15),
                    child: Row(
                      children: [
                        Text(
                          'Deadline in',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Text(
                            deadlineDate == null
                                ? 'Deadline Date'
                                : deadlineDate!,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.red,
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
                        Text(
                          isDeadlineAvailable
                              ? 'Still have time'
                              : 'No time left',
                          style: TextStyle(
                            fontSize: 20,
                            color:
                                isDeadlineAvailable ? Colors.green : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 16, bottom: 15),
                    child: Row(
                      children: [
                        Text(
                          'Done stats',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Done state:',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.blue),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: TextButton(
                            child: Text('Not Done',
                                style: TextStyle(
                                    decoration: isDone == true
                                        ? TextDecoration.underline
                                        : TextDecoration.none,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15,
                                    color: Colors.blue)),
                            onPressed: () {
                              User? user = _auth.currentUser;
                              String _uid = user!.uid;
                              if (_uid == widget.uploadBy) {
                                FirebaseFirestore.instance
                                    .collection('tasks')
                                    .doc(widget.taskId)
                                    .update({'isDone': true});
                                getData();
                              } else {
                                //showSnackBar
                              }
                            },
                          )),
                      Opacity(
                        opacity: isDone == true ? 1 : 0,
                        child: Icon(
                          Icons.check_box,
                          color: Colors.red,
                        ),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Expanded(
                          flex: 2,
                          child: TextButton(
                            child: Text('Done',
                                style: TextStyle(
                                  decoration: isDone == false
                                      ? TextDecoration.underline
                                      : TextDecoration.none,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15,
                                  color: Colors.blue,
                                )),
                            onPressed: () {
                              User? user = _auth.currentUser;
                              String _uid = user!.uid;
                              if (_uid == widget.uploadBy) {
                                FirebaseFirestore.instance
                                    .collection('tasks')
                                    .doc(widget.taskId)
                                    .update({'isDone': false});
                                getData();
                              } else {
                                //showSnackBar
                              }
                            },
                          )),
                      Opacity(
                        opacity: isDone == false ? 1 : 0,
                        child: Icon(
                          Icons.check_box,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 16, bottom: 15),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Task Description',
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
                            child: Text(
                              taskDescription == null ? '' : taskDescription!,
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
                  AnimatedSwitcher(
                    duration: Duration(milliseconds: 500),
                    child: _isCommenting
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                    ),
                                    errorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.pink),
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        MaterialButton(
                                          onPressed: () async {
                                            try {
                                              if (_commentController
                                                      .text.length <
                                                  7) {
                                                final _generatedId =
                                                    Uuid().v4();
                                                await FirebaseFirestore.instance
                                                    .collection('tasks')
                                                    .doc(widget.taskId)
                                                    .update({
                                                  'taskComments':
                                                      FieldValue.arrayUnion([
                                                    {
                                                      'userId': widget.uploadBy,
                                                      'commentId': _generatedId,
                                                      'name': authorName,
                                                      'commentBody':
                                                          _commentController
                                                              .text,
                                                      'time': Timestamp.now(),
                                                    }
                                                  ]),
                                                });
                                                showSnackBar(
                                                    context: context,
                                                    message:
                                                        'Comment uploaded successfully ',
                                                    error: true);
                                              } else {
                                                showSnackBar(
                                                    context: context,
                                                    message:
                                                        'Comment dos\'t  uploaded ',
                                                    error: false);
                                              }
                                              _commentController.clear();
                                              setState(() {

                                              });
                                            } catch (e) {
                                              showSnackBar(
                                                  context: context,
                                                  message:
                                                      'Comment dos\'t uploaded',
                                                  error: true);
                                            }
                                          },
                                          color: Colors.pink.shade700,
                                          elevation: 10,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(13),
                                              side: BorderSide.none),
                                          child: const Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 14,
                                            ),
                                            child: Text(
                                              'Post',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  // fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              setState(() {
                                                _isCommenting = !_isCommenting;
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
                                  borderRadius: BorderRadius.circular(13),
                                  side: BorderSide.none),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
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
                  SizedBox(
                    height: 7,
                  ),
                  Divider(),

                  FutureBuilder<DocumentSnapshot>(
                      future: FirebaseFirestore.instance
                          .collection('tasks')
                          .doc(widget.taskId)
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          if (snapshot.data == null) {
                            return Container();
                          }
                        }
                        return ListView.separated(
                            reverse: true,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (ctx, index) {
                              return commentsWidgets(
                                  name: snapshot.data!['taskComments'][index]
                                   ['name'],
                               userId: snapshot.data!['taskComments'][index]
                                   ['userId'],
                               commentId: snapshot.data!['taskComments'][index]
                                   ['commentId'],
                               description: snapshot.data!['taskComments']
                                   [index]['commentBody'],
                              );
                            },
                            separatorBuilder: (ctx, index) {
                              return Divider(
                                thickness: 1,
                              );
                            },
                            itemCount: snapshot
                                .data!['taskComments'].length);
                      })
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// FutureBuilder<DocumentSnapshot>(
//     future: FirebaseFirestore.instance
//         .collection('tasks')
//         .doc(widget.taskId)
//         .get(),
//     builder: (context, snapshot) {
//       if (snapshot.connectionState ==
//           ConnectionState.waiting) {
//         return Center(
//           child: CircularProgressIndicator(),
//         );
//       } else if (snapshot.data == null) {
//         return ListView.separated(
//           reverse: true,
//           shrinkWrap: true,
//           physics: NeverScrollableScrollPhysics(),
//           itemBuilder: (ctx, index) {
//             return commentsWidgets(
//               name: snapshot.data!['taskComments'][index]
//                   ['name'],
//               userId: snapshot.data!['taskComments'][index]
//                   ['userId'],
//               commentId: snapshot.data!['taskComments'][index]
//                   ['commentId'],
//               description: snapshot.data!['taskComments']
//                   [index]['commentBody'],
//             );
//           },
//           separatorBuilder:
//               (BuildContext context, int index) {
//             return Divider(
//               thickness: 1,
//             );
//           },
//           itemCount: snapshot.data!['taskComments'].length,
//         );
//       } else {
//         return Center(
//           child: Text('No comments found'),
//         );
//       }
//       return Center(
//         child: Text('Something went wrong'),
//       );
//     }),
//