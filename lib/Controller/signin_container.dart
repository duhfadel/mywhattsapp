import 'package:chat/Controller/user_cubit.dart';
import 'package:chat/Database/user_repository.dart';
import 'package:chat/View/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInContainer extends StatelessWidget {
  const SignInContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
        create: (context) {
          return UserCubit(UserRepository());
        },
        child: const LoginPage());
  }
}
