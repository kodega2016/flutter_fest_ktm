import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_festival_ktm/app/app.locator.dart';
import 'package:flutter_festival_ktm/data/models/app_user/app_user.dart';

abstract class BaseAuthService {
  Future<AppUser?> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<User?> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<void> signOut();
  Stream<AppUser?> get userChanges;
  AppUser? get currentUser;
}

class AuthService implements BaseAuthService {
  final FirebaseAuth _firebaseAuth = locator<FirebaseAuth>();

  @override
  Future<AppUser?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final UserCredential _authCredential = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);

    if (_authCredential.user != null) {
      return _mapUserToAppUser(_authCredential.user!);
    } else {
      throw FirebaseAuthException(code: 'FAILED_TO_LOGIN');
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Stream<AppUser?> get userChanges =>
      _firebaseAuth.userChanges().map(_mapUserToAppUser);

  @override
  AppUser? get currentUser => _firebaseAuth.currentUser != null
      ? _mapUserToAppUser(_firebaseAuth.currentUser!)
      : null;

  AppUser? _mapUserToAppUser(User? user) {
    if (user == null) return null;
    return AppUser(
      id: user.uid,
      displayName: user.displayName ?? 'App User',
      email: user.email!,
    );
  }

  @override
  Future<User> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    final UserCredential _userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await _userCredential.user?.updateDisplayName(name);
    if (_userCredential.user == null) {
      throw FirebaseAuthException(code: 'FAILED_TO_SIGN_UP');
    }
    return _userCredential.user!;
  }
}
