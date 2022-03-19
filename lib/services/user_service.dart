import 'package:firebase_helpers/firebase_helpers.dart';
import 'package:flutter_festival_ktm/constants/app_collections.dart';
import 'package:flutter_festival_ktm/data/models/app_user/app_user.dart';

abstract class BaseUserService {
  Future<void> createOrUpdateUser(AppUser user);
  Future<void> updateUser(AppUser user);
}

class UserService implements BaseUserService {
  final DatabaseService<AppUser> userDB = DatabaseService<AppUser>(
    AppCollections.users,
    fromDS: (id, data) {
      final _data = data;
      _data?['id'] = id;
      return AppUser.fromJson(_data!);
    },
    toMap: (user) => user.toJson(),
  );

  @override
  Future<void> updateUser(AppUser user) async {
    await userDB.create(user.toJson(), id: user.id);
  }

  @override
  Future<void> createOrUpdateUser(AppUser user) async {
    final _existingUser = await userDB.getSingle(user.id);
    if (_existingUser == null) {
      await userDB.create(user.copyWith().toJson(), id: user.id);
    } else {
      await userDB.create(_existingUser.toJson(), id: _existingUser.id);
    }
  }
}
