import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_festival_ktm/app/app.locator.dart';
import 'package:flutter_festival_ktm/app/app.logger.dart';
import 'package:flutter_festival_ktm/constants/app_assets.dart';
import 'package:flutter_festival_ktm/constants/app_routes.dart';
import 'package:flutter_festival_ktm/constants/app_strings.dart';
import 'package:flutter_festival_ktm/services/auth_service.dart';
import 'package:flutter_festival_ktm/services/user_service.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  final AuthService _authService = locator<AuthService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final UserService _userService = locator<UserService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();
  final Logger _logger = getLogger('LoginViewModel');

  static const String loginInProcess = 'loginInProcess';

  String? _email;
  String? _password;

  void changeEmail(String? val) {
    _email = val;
    notifyListeners();
  }

  void changePassword(String? val) {
    _password = val;
    notifyListeners();
  }

  bool get isFormValid =>
      (_email?.isNotEmpty ?? false) && (_password?.isNotEmpty ?? false);

  Future<void> login() async {
    try {
      setBusyForObject(loginInProcess, true);
      final _appUser = await _authService.signInWithEmailAndPassword(
        email: _email!,
        password: _password!,
      );
      if (_appUser != null) {
        _userService.createOrUpdateUser(_appUser);
        _logger.i(_appUser);
      }
      _navigationService.pushNamedAndRemoveUntil(AppRoutes.todos);
      _snackbarService
          .registerSnackbarConfig(AppAssets.SUCCESS_SNACKBAR_CONFIG);
      _snackbarService.showSnackbar(
        title: AppString.info,
        message: AppString.loggedIn,
      );
    } on FirebaseAuthException catch (e) {
      _logger.e(e);
      _snackbarService.registerSnackbarConfig(AppAssets.ERROR_SNACKBAR_CONFIG);
      _snackbarService.showSnackbar(
        title: AppString.info,
        message: e.message ?? e.toString(),
      );
    } catch (e) {
      _logger.e(e);
      _snackbarService.registerSnackbarConfig(AppAssets.ERROR_SNACKBAR_CONFIG);
      _snackbarService.showSnackbar(
        title: AppString.info,
        message: e.toString(),
      );
    } finally {
      setBusyForObject(loginInProcess, false);
    }
  }

  void navigateToRegister() {
    _navigationService.navigateTo(AppRoutes.register);
  }
}
