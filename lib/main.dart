import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tasks_app/scereens/add_tasks_screen.dart';
import 'package:tasks_app/scereens/app_screen.dart';
import 'package:tasks_app/scereens/auth/forget_password.dart';
import 'package:tasks_app/scereens/auth/login_screen.dart';
import 'package:tasks_app/scereens/auth/register_screen.dart';
import 'package:tasks_app/scereens/detail_screen.dart';
import 'package:tasks_app/scereens/profile_screen.dart';
import 'package:tasks_app/scereens/registered_workers_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFEDE7DC),
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login_screen',
      routes: {
        '/login_screen':(context)=>const LoginScreen(),
        '/register_screen':(context)=>const RegisterScreen(),
        '/forget_password':(context)=>const ForgetPassword(),
        '/app_screen':(context)=> AppScreen(),
        '/add_tasks_screen':(context)=> AddTasks(),
        '/registered_worker_screen':(context)=> RegisteredWorkerScreen(),
        // '/profile_screen':(context)=> ProfileScreen(),
        '/detail_screen':(context)=> DetailScreen(),
      },
    );
  }
}
