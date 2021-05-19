import 'package:flutter/material.dart';

class TitleCard extends StatelessWidget {
  const TitleCard({Key key, @required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
    );
  }
}

class MessageCard extends StatelessWidget {
  const MessageCard({Key key, @required this.message}) : super(key: key);
  final String message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(message, style: const TextStyle(fontSize: 15, height: 1.3)),
    );
  }
}
