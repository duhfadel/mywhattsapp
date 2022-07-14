import 'package:chat/Model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:chat/Controller/user_cubit.dart';
import 'package:chat/Model/user.dart';

class ChatBox extends StatelessWidget {
  const ChatBox({
    Key? key,
    required this.userCubit,
    required this.contact,
  }) : super(key: key);
  final UserCubit userCubit;
  final User contact;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('User')
              .doc(userCubit.state.user?.email)
              .collection("Contacts")
              .doc(contact.email)
              .collection('Messages')
              .orderBy('time', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              default:
                List<Message> messages = snapshot.data!.docs
                    .map((e) => Message.fromSnapshot(e))
                    .toList();

                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: messages.length,
                    reverse: true,
                    itemBuilder: (context, index) {
                      Message? message = messages[index];
                      String _sender() {
                        String sender = '';
                        if (message.from == userCubit.state.user?.email) {
                          sender = 'You';
                        } else if (message.from == contact.email) {
                          sender = contact.name ?? '';
                        }
                        return sender;
                      }

                      return Card(
                        child: ListTile(
                          title: Text(message.text),
                          subtitle: Text(
                            _sender(),
                          ),
                          isThreeLine: true,
                        ),
                      );
                    });
            }
          }),
    );
  }
}
