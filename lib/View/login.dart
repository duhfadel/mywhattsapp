import 'package:chat/Controller/user_cubit.dart';
import 'package:chat/View/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserCubit userCubit = context.read<UserCubit>();

    return Scaffold(
      appBar: AppBar(title: const Text('Hello, please login with Google!')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const Padding(
              padding: EdgeInsets.all(26.0),
              child: Icon(
                Icons.chat,
                size: 50,
                color: Colors.blue,
              ),
            ),
            const Text(
              'Chat With Me!',
              style: TextStyle(fontSize: 25, color: Colors.blueGrey),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: ElevatedButton(
                  onPressed: () {
                    context.read<UserCubit>().signIn();
                    navigateHome(context, userCubit);
                  },
                  child: SizedBox(
                    height: 100,
                    width: 150,
                    child: Row(
                      children: const [
                        Icon(Icons.email),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Google Sign in!'),
                        ),
                      ],
                    ),
                  )),
            ),
          ]),
        ),
      ),
    );
  }

  Future<void> navigateHome(BuildContext context, UserCubit userCubit) async {
    //checkLogin returns a bool true if it's logged, so it sends to our next page
    if (await userCubit.checkLogin()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(userCubit: userCubit),
        ),
      );
    }
  }
}
