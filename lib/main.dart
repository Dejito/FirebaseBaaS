import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/screens/auth_screen.dart';
import 'package:firebase_chat/screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    runApp(const MyApp());
    WidgetsFlutterBinding.ensureInitialized();
  } catch (e) {
    runApp(const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> fApp = Firebase.initializeApp();
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.pink,
          backgroundColor: Colors.pink,
          hintColor: Colors.deepPurple,
          highlightColor: Colors.deepPurpleAccent,
          brightness: Brightness.light,
          buttonTheme: ButtonTheme.of(context).copyWith(
            buttonColor: Colors.pink,
            textTheme: ButtonTextTheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              return const ChatScreen();
            } else {
              return const AuthScreen();
            }
          },)
      // FutureBuilder(
      //   future: fApp,
      //   builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
      //     if (snapshot.hasError) {
      //       return  Center(
      //         child: Text("Something went wrong! ${snapshot.toString()}."),
      //       );
      //     } else if (snapshot.hasData) {
      //       return  const
      //       // AuthScreen();
      //       ChatScreen();
      //     } else {
      //       return Center(
      //         child: Text(snapshot.toString()),
      //       );
      //     }
      //   },
      //   // child: const ChatScreen()),
      // ),
    );
  }
}
