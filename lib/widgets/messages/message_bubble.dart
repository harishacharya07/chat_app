import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String messages;
  final bool isMe;
  final String userId;

  MessageBubble(
    this.messages,
    this.isMe,
    this.userId,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(12),
              bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
            ),
            color: isMe ? Colors.grey[300] : Theme.of(context).accentColor,
          ),
          width: 140,
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          margin: EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 8,
          ),
          child: Column(
            children: [
              Text(
                userId,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                messages,
                style: TextStyle(
                  color: isMe
                      ? Colors.black
                      : Theme.of(context).accentTextTheme.headline1.color,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
