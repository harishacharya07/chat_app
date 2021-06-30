import 'package:chatapp/widgets/messages/message_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // return FutureBuilder(
    //   future: user.currentUser,
    //   builder: (ctx, featureSnapShot) {
    //     if (featureSnapShot.connectionState == ConnectionState.waiting) {
    //       return Center(
    //         child: CircularProgressIndicator(),
    //       );
    //     }
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy(
        'createdAt',
        descending: true,
      )
          .snapshots(),
      builder: (ctx, dataSnapShot) {
        if (dataSnapShot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDocs = dataSnapShot.data.documents;
        return ListView.builder(
          reverse: true,
          itemCount: chatDocs.length,
          itemBuilder: (ctx, index) {
            return MessageBubble(
              chatDocs[index]['text'],
              chatDocs[index]['userId'] == FirebaseAuth.instance.currentUser,
              chatDocs[index]['userId'],
            );
          },
        );
      },
    );
  }
}
