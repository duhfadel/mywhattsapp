import 'package:chat/Controller/user_cubit.dart';
import 'package:chat/Model/user.dart';
import 'package:chat/View/chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeContacts extends StatelessWidget {
  const HomeContacts({Key? key, required this.userCubit}) : super(key: key);

  final UserCubit userCubit;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('User')
            .doc(userCubit.state.user?.email)
            .collection('Contacts')
            .snapshots(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            default:
              List<User> contacts =
                  snapshot.data!.docs.map((e) => User.fromSnapshot(e)).toList();
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: contacts.length,
                  itemBuilder: (context, index) {
                    User? contact = contacts[index];
                    return Column(
                      children: [
                        Card(
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatView(userCubit: userCubit, contact: contact),
                                ),
                              );
                            },
                            title: Text(contact.name ?? ''),
                            subtitle: Text(contact.email ?? ''),
                          ),
                        )
                      ],
                    );
                  });
          }
        });
  }
}


          /*
           
           
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('User')
          .doc()
          .collection('Contacts')
          .snapshots(),
      builder: ((context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(),
            );
          default:
            if (snapshot.hasData) {
              List<User> contacts = snapshot.data!.docs
                  .map((e) => User.fromJson(e.data() as Map<String, dynamic>))
                  .toList();
              return SingleChildScrollView(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: contacts.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Card(
                            child: ListTile(
                              title: Text(contacts[index].name ?? ''),
                              subtitle: Text(contacts[index].email ?? ''),
                            ),
                          )
                        ],
                      );
                    }),
              );
            } else {
              return const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  'You don\'t have contacts yet! Start adding',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              );
            }
        }
      }),
    );
  }
}
*/