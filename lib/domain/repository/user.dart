import 'package:child_museum/domain/entity/user/user.dart';
import 'package:image_picker/image_picker.dart';

abstract class UserRepository {
  Future<User> getUser(String userId);
  Future<List<User>> getUsersByUids(List<String> uids);
  Future<User> createUser(String userId, String name, String email);
  Future<void> updateUser(String userId, String? username, String? email);
  Future<void> deleteUser(String userId);
  Future<String> updatePhotoUrl(String userId, XFile photoUrl);
  Future<List<User>> searchUserByEmail({required String email});
}
