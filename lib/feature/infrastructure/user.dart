import 'dart:io';

import 'package:child_museum/domain/entity/user/user.dart';
import 'package:child_museum/domain/repository/user.dart';
import 'package:child_museum/feature/infrastructure/firebase/firestore.dart';
import 'package:child_museum/feature/infrastructure/mapper/user_mapper.dart';
import 'package:child_museum/feature/infrastructure/util/image_compressor.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class IUserRepository implements UserRepository {
  IUserRepository();

  final _userDB = Firestore.user;

  @override
  Future<User> createUser(String userId, String name, String email) {
    final regUser = User(
      uid: userId,
      username: name,
      email: email,
      photoUrl: null,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      deletedAt: null,
    );
    _userDB.doc(userId).set(UserMapper.toJSON(regUser));
    return Future.value(regUser);
  }

  @override
  Future<void> deleteUser(String userId) async {
    await _userDB.doc(userId).update(
      {
        'deletedAt': DateTime.now(),
      },
    );
  }

  @override
  Future<User> getUser(String userId) async {
    final user = await _userDB.doc(userId).get().then((value) {
      return UserMapper.fromJSON(value.data()!);
    });
    return user;
  }

  @override
  Future<void> updateUser(
      String userId, String? username, String? email) async {
    await _userDB.doc(userId).update(
      {
        'username': username,
        'email': email,
        'updatedAt': DateTime.now(),
      },
    );
  }

  @override
  Future<String> updatePhotoUrl(String userId, XFile photoUrl) async {
    try {
      final strImageUrls = await IUserRepository._uploadImage(
        image: photoUrl,
        userId: userId,
      );
      await _userDB.doc(userId).update(
        {
          'photoUrl': strImageUrls,
          'updatedAt': DateTime.now(),
        },
      );
      return strImageUrls;
    } catch (e) {
      throw Exception('Failed to upload image$e');
    }
  }

  static Future<String> _uploadImage(
      {required XFile image, required String userId}) async {
    try {
      final fileName = image.name;
      final data = await ImageCompressor().compress(
        File(image.path).readAsBytesSync(),
        1 * 1024 * 1024,
      );
      final storageRef =
          FirebaseStorage.instance.ref().child('users/$userId/$fileName');
      await storageRef.putData(data);
      final url = await storageRef.getDownloadURL();
      return url;
    } catch (e) {
      throw Exception('Failed to upload image$e');
    }
  }

  @override
  Future<List<User>> getUsersByUids(List<String> uids) {
    if (uids.isEmpty) {
      return Future.value([]);
    }
    return _userDB.where('uid', whereIn: uids).get().then((value) {
      return value.docs.map((e) {
        return UserMapper.fromJSON(e.data());
      }).toList();
    });
  }

  @override
  Future<List<User>> searchUserByEmail({required String email}) {
    return _userDB.where('email', isEqualTo: email).get().then(
      (value) {
        return value.docs.map((e) {
          return UserMapper.fromJSON(e.data());
        }).toList();
      },
    );
  }
}

final userRepositoryProvider = Provider<IUserRepository>((ref) {
  return IUserRepository();
});
