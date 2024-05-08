import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final currentUserProvider = StreamProvider<User?>(
  (ref) async* {
    await for (var user in FirebaseAuth.instance.authStateChanges()) {
      if (user != null) {
        await user.reload();
        var freshUser = FirebaseAuth.instance.currentUser;
        yield freshUser;
      } else {
        yield user;
      }
    }
  },
);
