import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chat/Controller/signstate.dart';
import 'package:chat/Controller/user_cubit.dart';

class HomeTitle extends StatelessWidget {
  const HomeTitle({
    Key? key,
    required this.userCubit,
  }) : super(key: key);
  final UserCubit userCubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, SignState>(
      bloc: userCubit,
      builder: ((context, state) => Text('Wellcome ${state.user?.name ?? ''}')),
    );
  }
}
