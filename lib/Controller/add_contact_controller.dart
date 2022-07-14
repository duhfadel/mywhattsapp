import 'package:chat/Controller/user_cubit.dart';
import 'package:chat/Model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddContactController {
  final UserCubit userCubit;
  late final User user;

  AddContactController({required this.userCubit, required});

  void addToList(context, userCubit, User user) {

    FirebaseFirestore.instance
        .collection('User')
        .doc(userCubit.state.user?.email)
        .collection('Contacts')
        .doc(user.email)
        .set(user.toJson());

    Navigator.pop(context);
  }
}
