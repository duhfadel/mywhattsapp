import 'package:chat/Model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:chat/Controller/user_cubit.dart';
import 'package:chat/Model/user.dart';

class ChatWriter extends StatelessWidget {
  ChatWriter({
    Key? key,
    required this.userCubit,
    required this.contact,
  }) : super(key: key);
  final UserCubit userCubit;
  final User contact;

  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.camera),
        ),
        Expanded(
          child: TextField(
            controller: _textController,
            decoration: const InputDecoration.collapsed(
                hintText: 'Write your message here'),
          ),
        ),
        IconButton(
            onPressed: () {
              if (_textController.text.isNotEmpty) {
                _saveMessageFrom();
                _saveMessageTo();
                _textController.clear();
              }
            },
            icon: const Icon(Icons.send))
      ]),
    );
  }

  _saveMessageFrom() {
    String text = _textController.text;
    DateTime date = DateTime.now().toUtc();
    Message message = Message(
        text: text,
        to: contact.email,
        from: userCubit.state.user!.email,
        time: date);
    FirebaseFirestore.instance
        .collection('User')
        .doc(userCubit.state.user?.email)
        .collection("Contacts")
        .doc(contact.email)
        .collection('Messages')
        .doc()
        .set(message.toJson());
  }

  _saveMessageTo() async {
    String text = _textController.text;
    DateTime date = DateTime.now().toUtc();

    Message message = Message(
        text: text,
        to: contact.email,
        from: userCubit.state.user!.email,
        time: date);

    FirebaseFirestore.instance
        .collection('User')
        .doc(contact.email)
        .collection("Contacts")
        .doc(userCubit.state.user!.email)
        .collection('Messages')
        .doc()
        .set(message.toJson());
  }
}
