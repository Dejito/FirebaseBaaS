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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FutureBuilder(
        future: fApp,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return  Center(
              child: Text("Something went wrong! ${snapshot.toString()}."),
            );
          } else if (snapshot.hasData) {
            return  const ChatScreen();
          } else {
            return Center(
              child: Text(snapshot.toString()),
            );
          }
        },
        // child: const ChatScreen()),
      ),
    );
  }
}
