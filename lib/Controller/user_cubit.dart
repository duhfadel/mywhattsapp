import 'package:chat/Controller/signstate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat/Database/user_repository.dart';
import 'package:chat/Model/user.dart' as u;

class UserCubit extends Cubit<SignState> {
  UserCubit(
    this.userRepository,
  ) : super(SignState());

  final UserRepository userRepository;

  List<u.User>? contactList = [];

  Future<bool> signIn() async {
    emit(SignState(isLoading: true));
    u.User? user = await userRepository.signInGoogle();
    if (user != null) {
      emit(SignState(user: user));
      return true;
    }
    return false;
  }

  Future<bool> checkLogin() async {
    try {
      await signIn();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> signOut() async {
    try {
      await userRepository.signOutGoogle();
      return true;
    } catch (e) {
      return false;
    }
  }


  addContacttoList(context, user) {
    contactList?.add(user);
    FirebaseFirestore.instance
        .collection('User')
        .doc(state.user?.email)
        .collection("Contacts")
        .doc()
        .set(user.toJson());
    Navigator.pop(context);
  }

  Future<List<u.User>?> showContacts() async {
    List<u.User>? contacts = await FirebaseFirestore.instance
        .collection('User')
        .doc(state.user?.email)
        .collection('Contacts')
        .snapshots()
        .map(
          (e) => e.docs
              .map(
                (d) => u.User.fromJson(
                  d.data(),
                ),
              )
              .toList(),
        )
        .first;
    return contacts;
  }
}
