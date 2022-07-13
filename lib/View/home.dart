import 'package:chat/Controller/home_contacts.dart';
import 'package:chat/Controller/user_cubit.dart';
import 'package:chat/Controller/signstate.dart';
import 'package:chat/View/add_contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.userCubit}) : super(key: key);

  final UserCubit userCubit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<UserCubit, SignState>(
          bloc: userCubit,
          builder: ((context, state) =>
              Text('Wellcome ${state.user?.name ?? ''}')),
        ),
        actions: [
          IconButton(
              onPressed: () {
                _popLogOut(context);
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            HomeContacts(userCubit: userCubit),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            navigateAddContact(context, userCubit);
          },
          child: const Icon(Icons.add)),
    );
  }

  Future<void> _popLogOut(context) async {
    //Receive bool true if logout is done
    if (await userCubit.signOut()) {
      Navigator.pop(context);
    }
  }

  void navigateAddContact(context, userCubit) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddContactPage(userCubit: userCubit),
      ),
    );
  }
}
