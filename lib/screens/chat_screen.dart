import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final fireStore = FirebaseFirestore.instance;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chats"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(itemBuilder: (context, i) =>
            const Text("T'emi tomi leru"),
          itemCount: 2,
        ),
      ),
      floatingActionButton: FloatingActionButton(

        onPressed: () {
          fireStore.collection("chat/WyLC7SqQqZTn2aQDIhvy/messages")
              .snapshots().listen((event) {
                event.docs.forEach((element) {
                  print(element.data().values);
                });

          });
          //     .forEach((element) {
          //   print(element);
          // });
        },
      ),
    );
  }
}