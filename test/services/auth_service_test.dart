import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_festival_ktm/app/app.locator.dart';
import 'package:flutter_festival_ktm/data/models/app_user/app_user.dart';
import 'package:flutter_festival_ktm/services/auth_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mocks.mocks.dart';
import '../setup.dart';

Future<void> main() async {
  group('AuthServiceTest -', () {
    late FirebaseAuth firebaseAuth;

    late AuthService authService;

    setUp(() {
      registerServices();
      firebaseAuth = locator<FirebaseAuth>();
      authService = AuthService();
    });
    tearDown(() => unregisterServices());

    group('signInWithEmailAndPassword', () {
      const String _email = 'example@example.com';
      const String _password = 'password';
      const String _id = 'id';
      const String _displayName = 'name';

      final UserCredential? _userCredential = MockUserCredential();
      final User? _user = MockUser();
      const AppUser? _appUser = AppUser(
        id: _id,
        displayName: _displayName,
        email: _email,
      );

      test(
          'When signInWithEmailAndPassword is called it should call the firebase auth[signInWithEmailAndPassword]',
          () async {
        when(_userCredential!.user).thenReturn(_user);
        when(_user!.uid).thenReturn(_id);
        when(_user.displayName).thenReturn(_displayName);
        when(_user.email).thenReturn(_email);
        when(firebaseAuth.signInWithEmailAndPassword(
                email: _email, password: _password))
            .thenAnswer((_) async => Future.value(_userCredential));

        await authService.signInWithEmailAndPassword(
            email: _email, password: _password);
        verify(firebaseAuth.signInWithEmailAndPassword(
                email: _email, password: _password))
            .called(1);
      });
      test('When signInWithEmailAndPassword is success it should retrun User',
          () async {
        when(_userCredential!.user).thenReturn(_user);
        when(_user!.uid).thenReturn(_id);
        when(_user.displayName).thenReturn(_displayName);
        when(_user.email).thenReturn(_email);
        when(firebaseAuth.signInWithEmailAndPassword(
                email: _email, password: _password))
            .thenAnswer((_) async => Future.value(_userCredential));

        final _result = await authService.signInWithEmailAndPassword(
            email: _email, password: _password);
        expect(_result, equals(_appUser));
      });

      test(
          'When signInWithEmailAndPassword is failed it should throw FirebaseAuthException',
          () {
        when(_userCredential!.user).thenReturn(null);
        when(_user!.uid).thenReturn(_id);
        when(_user.displayName).thenReturn(_displayName);
        when(_user.email).thenReturn(_email);
        when(firebaseAuth.signInWithEmailAndPassword(
                email: _email, password: _password))
            .thenAnswer((_) async => Future.value(_userCredential));

        expect(
            () => authService.signInWithEmailAndPassword(
                email: _email, password: _password),
            throwsA(isA<FirebaseAuthException>()));
      });
    });

    group('signOut', () {
      test('When signOut is called it should call the firebase auth[signOut]',
          () async {
        when(firebaseAuth.signOut())
            .thenAnswer((_) async => Future.value(null));
        await authService.signOut();
        verify(firebaseAuth.signOut()).called(1);
      });
    });

    group('userChanges', () {
      const String _email = 'example@example.com';
      const String _id = 'id';
      const String _displayName = 'name';

      final User? _user = MockUser();

      final UserCredential? _userCredential = MockUserCredential();

      final Stream<User?> _userStream = Stream.value(_user).asBroadcastStream();

      test('When userChanges is called it should call auth[userChanges]',
          () async {
        when(firebaseAuth.userChanges()).thenAnswer((_) => _userStream);
        authService.userChanges;
        verify(firebaseAuth.userChanges()).called(1);
      });

      test('When userChanges is called it should stream appuser', () async {
        when(_userCredential!.user).thenReturn(_user);
        when(_user!.uid).thenReturn(_id);
        when(_user.displayName).thenReturn(_displayName);
        when(_user.email).thenReturn(_email);
        when(firebaseAuth.userChanges()).thenAnswer((_) => _userStream);

        when(firebaseAuth.authStateChanges())
            .thenAnswer((_) => Stream.fromIterable([_user]));

        final _result = authService.userChanges;
        expect(await _result.first, isA<AppUser>());
      });
    });

    group('signUpWithEmailAndPassword', () {});
    //TODO::Perform test for this stuck due to firebase code failed to initialize
  });
}
