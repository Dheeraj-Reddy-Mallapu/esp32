import 'package:esp32/presentation/widgets/my_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

@riverpod
class UserNotifier extends _$UserNotifier {
  @override
  User? build() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      state = user;
    });
    return FirebaseAuth.instance.currentUser;
  }

  Future<void> loginInWithEmail(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email' ||
          e.code == 'wrong-password' ||
          e.code == 'invalid-credential') {
        showSnackBar(message: 'Email or Password is invalid');
      } else if (e.code == 'user-not-found') {
        showSnackBar(message: 'User not found, please register');
      } else {
        showSnackBar(message: e.code);
      }
    }
  }

  Future<void> registerWithEmail(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        showSnackBar(message: 'Email or Password is invalid');
      } else if (e.code == 'email-already-in-use') {
        showSnackBar(message: 'Email already exists, please login');
      } else if (e.code == 'weak-password') {
        showSnackBar(message: 'Entered password is not strong enough');
      }
    }
  }

  Future<void> signOut() async => await FirebaseAuth.instance.signOut();
}
