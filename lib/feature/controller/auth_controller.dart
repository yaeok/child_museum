import 'package:child_museum/domain/repository/auth.dart';
import 'package:child_museum/domain/repository/user.dart';
import 'package:child_museum/feature/infrastructure/auth.dart';
import 'package:child_museum/feature/infrastructure/user.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthNotifier extends StateNotifier<Future<void>> {
  AuthNotifier({
    required this.authRepository,
    required this.userRepository,
  }) : super(
          Future.value(null),
        );

  final AuthRepository authRepository;
  final UserRepository userRepository;

  Future<void> signUpWithEmail(String email, String password) async {
    final userId = await authRepository.signUpWithEmail(email, password);
    await userRepository.createUser(userId, '未設定', email);
  }

  Future<void> signInWithEmail(String email, String password) async {
    await authRepository.signInWithEmail(email, password);
  }

  Future<void> signOut() async {
    await authRepository.signOut();
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await authRepository.sendPasswordResetEmail(email);
  }

  Future<void> deleteUser() async {
    await authRepository.deleteUser();
  }
}

final authControllerProvider =
    StateNotifierProvider.autoDispose<AuthNotifier, Future<void>>(
  (ref) {
    return AuthNotifier(
      authRepository: ref.watch(authRepositoryProvider),
      userRepository: ref.watch(userRepositoryProvider),
    );
  },
);
