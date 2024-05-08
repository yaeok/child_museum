abstract class AuthRepository {
  Future<String> signInWithEmail(String email, String password);
  Future<String> signUpWithEmail(String email, String password);
  Future<void> signOut();
  Future<void> sendPasswordResetEmail(String email);
  Future<void> deleteUser();
}
