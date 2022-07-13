import 'package:chat/Controller/user_cubit.dart';
import 'package:chat/Model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddContactController {
  final UserCubit userCubit;
  final String name;
  final String email;

  AddContactController(
      {required this.userCubit, required this.name, required this.email});

  void addToList(context, userCubit, name, email) {
    User user = User(name: this.name, email: this.email);
    FirebaseFirestore.instance
        .collection('User')
        .doc(userCubit.state.user?.id)
        .collection('Contacts')
        .doc()
        .set(user.toJson());

    Navigator.pop(context);
  }
}
