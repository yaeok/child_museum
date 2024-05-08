import 'package:child_museum/domain/entity/user/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserMapper {
  static User fromJSON(Map<String, dynamic> json) {
    final createdAt = json['createdAt'] as Timestamp;
    final updatedAt = json['updatedAt'] as Timestamp;
    final deletedAt = json['deletedAt'] as Timestamp?;
    return User(
      uid: json['uid'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      photoUrl: json['photoUrl'] as String?,
      createdAt: createdAt.toDate(),
      updatedAt: updatedAt.toDate(),
      deletedAt: deletedAt?.toDate(),
    );
  }

  static Map<String, dynamic> toJSON(User user) {
    return {
      'uid': user.uid,
      'username': user.username,
      'email': user.email,
      'photoUrl': user.photoUrl,
      'createdAt': Timestamp.fromDate(user.createdAt),
      'updatedAt': Timestamp.fromDate(user.updatedAt),
      'deletedAt':
          user.deletedAt != null ? Timestamp.fromDate(user.deletedAt!) : null,
    };
  }
}
