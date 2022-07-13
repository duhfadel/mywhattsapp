import 'package:chat/Model/user.dart';

class SignState {
  bool isLoading = false;
  User? user;
  SignState({
    this.isLoading = false,
    this.user,
  });
}
