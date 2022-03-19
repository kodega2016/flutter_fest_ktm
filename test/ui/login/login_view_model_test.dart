import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_festival_ktm/app/app.locator.dart';
import 'package:flutter_festival_ktm/constants/app_routes.dart';
import 'package:flutter_festival_ktm/constants/app_strings.dart';
import 'package:flutter_festival_ktm/data/models/app_user/app_user.dart';
import 'package:flutter_festival_ktm/services/auth_service.dart';
import 'package:flutter_festival_ktm/ui/login/login_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../setup.dart';

void main() {
  group('LoginViewModelTest -', () {
    late AuthService authService;
    late SnackbarService snackbarService;
    late NavigationService navigationService;
    late LoginViewModel viewModel;

    setUp(() {
      registerServices();
      authService = locator<AuthService>();
      snackbarService = locator<SnackbarService>();
      navigationService = locator<NavigationService>();
      viewModel = LoginViewModel();
    });
    tearDown(() => unregisterServices());

    test('Initially the model is clear', () {
      expect(viewModel.isBusy, false);
      expect(viewModel.hasError, false);
    });

    group('login', () {
      const _email = 'example@example.com';
      const _password = 'password';
      const _id = 'id';
      const _displayName = 'Name';
      const AppUser? _appUser = AppUser(
        id: _id,
        displayName: _displayName,
        email: _email,
      );

      test(
          'When login is called it will call the authService[signInWithEmailAndPassword]',
          () async {
        when(navigationService.pushNamedAndRemoveUntil(AppRoutes.todos))
            .thenReturn(null);

        when(snackbarService.showSnackbar(
          title: AppString.info,
          message: AppString.loggedIn,
        )).thenReturn(null);
        when(authService.signInWithEmailAndPassword(
                email: _email, password: _password))
            .thenAnswer((_) async => Future.value(_appUser));
        viewModel.changeEmail(_email);
        viewModel.changePassword(_password);

        await viewModel.login();
        verify(authService.signInWithEmailAndPassword(
          email: _email,
          password: _password,
        )).called(1);
      });

      test('When login is success it will show the snackbar', () async {
        when(navigationService.pushNamedAndRemoveUntil(AppRoutes.todos))
            .thenReturn(null);

        when(snackbarService.showSnackbar(
          title: AppString.info,
          message: AppString.loggedIn,
        )).thenReturn(null);
        when(authService.signInWithEmailAndPassword(
                email: _email, password: _password))
            .thenAnswer((_) async => Future.value(_appUser));
        viewModel.changeEmail(_email);
        viewModel.changePassword(_password);

        await viewModel.login();
        verify(
          snackbarService.showSnackbar(
            title: AppString.info,
            message: AppString.loggedIn,
          ),
        ).called(1);
      });
      test('When login is failed it will show the snackbar', () async {
        const _message = 'Failed to login';
        final e = FirebaseAuthException(message: _message, code: '');
        when(snackbarService.showSnackbar(
          title: AppString.info,
          message: _message,
        )).thenReturn(null);

        when(authService.signInWithEmailAndPassword(
                email: _email, password: _password))
            .thenThrow(e);

        viewModel.changeEmail(_email);
        viewModel.changePassword(_password);

        await viewModel.login();
        verify(
          snackbarService.showSnackbar(
            title: AppString.info,
            message: _message,
          ),
        ).called(1);
      });
    });

    group('navigateToRegister', () {
      test('When navigateToRegister is called it should navigate to register',
          () {
        when(navigationService.navigateTo(AppRoutes.register)).thenReturn(null);

        viewModel.navigateToRegister();
        verify(navigationService.navigateTo(AppRoutes.register)).called(1);
      });
    });
  });
}
