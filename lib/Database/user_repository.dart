import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:chat/Model/user.dart' as u;

class UserRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  List<u.User>? contactList;

  Future<u.User?> signInGoogle() async {
    final GoogleSignInAccount? googleSignInAccount =
        await _googleSignIn.signIn();
    User? user;
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      // Getting users credential
      UserCredential result = await _auth.signInWithCredential(authCredential);
      user = result.user;
      if (user != null) {
        contactList = await FirebaseFirestore.instance
            .collection('User')
            .doc()
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
      }
    }
    return u.User(
        name: user?.displayName,
        id: user?.uid,
        email: user?.email,
        contactList: contactList ?? []);
  }

  Future<void> signOutGoogle() async {
    await _googleSignIn.signOut();
  }
}
