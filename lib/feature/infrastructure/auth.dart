import 'package:child_museum/domain/repository/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class IAuthRepository implements AuthRepository {
  IAuthRepository();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<String> signUpWithEmail(String email, String password) async {
    UserCredential? userCredential;
    try {
      userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCredential.user!.sendEmailVerification();
    } catch (e) {
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'email-already-in-use':
            throw 'email-already-in-use';
          default:
            return '';
        }
      }
    }
    return userCredential!.user!.uid;
  }

  @override
  Future<String> signInWithEmail(String email, String password) async {
    UserCredential? userCredential;
    try {
      userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      if (e is FirebaseAuthException) {
        switch (e.code) {
          // ログイン失敗した場合 === Authenticationにはアカウントが存在しない場合、新しくAuthenticationにユーザーを作成
          case 'user-not-found':
            throw 'user-not-found';
          // Authenticationにアカウントが存在するが、パスワードが違う場合はエラーを返す
          case 'wrong-password':
            throw 'wrong-password';
          // ログイン失敗が多く続いた場合はエラーを返す
          case 'too-many-requests':
            throw 'too-many-requests';
          default:
            return '';
        }
      }
    }
    return userCredential!.user!.uid;
  }

  @override
  Future<void> signOut() {
    return _auth.signOut();
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw FirebaseAuthException(
        code: 'sendPasswordResetEmail',
        message: e.toString(),
      );
    }
  }

  @override
  Future<void> deleteUser() async {
    final userCredential = _auth.currentUser;
    if (userCredential != null) {
      return await userCredential.delete();
    }
  }
}

final authRepositoryProvider = Provider<IAuthRepository>(
  (ref) => IAuthRepository(),
);
