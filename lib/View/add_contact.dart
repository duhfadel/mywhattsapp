import 'package:chat/Controller/add_contact_controller.dart';
import 'package:chat/Controller/user_cubit.dart';
import 'package:chat/Model/user.dart';
import 'package:flutter/material.dart';

class AddContactPage extends StatelessWidget {
  AddContactPage({Key? key, required this.userCubit}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final UserCubit userCubit;
  late final AddContactController addContactController =
      AddContactController(userCubit: userCubit);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Contact'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              label: Text('Please write your contact name'),
            ),
          ),
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(
              label: Text('Please write your contact email'),
            ),
          ),
          ElevatedButton(
            child: const Text('Ok'),
            onPressed: () {
              User user = User(
                  name: _nameController.text, email: _emailController.text);
              addContactController.addToList(context, userCubit, user);
              //add on contactList is not necessary because info is comming from database
              userCubit.state.user?.contactList.add(user);
            },
          )
        ],
      ),
    );
  }
}
