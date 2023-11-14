import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/widget/chat/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  Future<User?> _getCurrentUser() async {
    return FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getCurrentUser(),
      builder: (ctx, futureSnapshot) {
        if (futureSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('chat')
                .orderBy(
                  'createdAt',
                  descending: true,
                )
                .snapshots(),
            builder: (ctx, chatSnapshot) {
              if (chatSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final chatDocs = chatSnapshot.data?.docs;
              return ListView.builder(
                reverse: true,
                itemCount: chatDocs?.length,
                itemBuilder: (ctx, index) => MessageBubble(
                  chatDocs?[index]['text'],
                  chatDocs?[index]['userId'] == futureSnapshot.data?.uid,
                  chatDocs?[index]['userName'],
                  chatDocs?[index]['userImage']
                ),
              );
            });
      },
    );
  }
}
