import 'package:chat/Controller/chat_box.dart';
import 'package:flutter/material.dart';

import 'package:chat/Controller/chat_writer.dart';
import 'package:chat/Controller/user_cubit.dart';
import 'package:chat/Model/user.dart';

class ChatView extends StatelessWidget {
  const ChatView({
    Key? key,
    required this.userCubit,
    required this.contact,
  }) : super(key: key);
  final UserCubit userCubit;
  final User contact;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ChatBox(userCubit: userCubit, contact: contact),
          ChatWriter(
            userCubit: userCubit,
            contact: contact,
          ),
        ],
      ),
    );
  }
}
