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
          child: StreamBuilder(
            stream: fireStore.collection("chat/WyLC7SqQqZTn2aQDIhvy/messages")
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text("Something went wrong!"),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final documents = snapshot.data?.docs;
                return ListView.builder(itemBuilder: (context, i) =>
                 Text(documents?[i]['text']),
                  itemCount: documents?.length,
                );

            },
          )


      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //   },
      // ),
    );
  }
}