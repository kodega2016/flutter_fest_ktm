import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_festival_ktm/app/app.locator.dart';
import 'package:flutter_festival_ktm/app/app.logger.dart';
import 'package:flutter_festival_ktm/constants/app_assets.dart';
import 'package:flutter_festival_ktm/constants/app_routes.dart';
import 'package:flutter_festival_ktm/constants/app_strings.dart';
import 'package:flutter_festival_ktm/data/models/app_user/app_user.dart';
import 'package:flutter_festival_ktm/services/auth_service.dart';
import 'package:flutter_festival_ktm/services/user_service.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RegisterViewModel extends BaseViewModel {
  final AuthService _authService = locator<AuthService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final UserService _userService = locator<UserService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();
  final Logger _logger = getLogger('RegisterViewModel');

  static const String registerInProcess = 'registerInProcess';

  String? _name;
  String? _email;
  String? _password;

  void changeName(String? val) {
    _name = val;
    notifyListeners();
  }

  void changeEmail(String? val) {
    _email = val;
    notifyListeners();
  }

  void changePassword(String? val) {
    _password = val;
    notifyListeners();
  }

  bool get isFormValid =>
      (_email?.isNotEmpty ?? false) &&
      (_password?.isNotEmpty ?? false) &&
      (_name?.isNotEmpty ?? false);

  Future<void> register() async {
    try {
      setBusyForObject(registerInProcess, true);
      final _user = await _authService.signUpWithEmailAndPassword(
        name: _name!,
        email: _email!,
        password: _password!,
      );
      final _appUser =
          AppUser(id: _user.uid, displayName: _name!, email: _email!);
      await _userService.createOrUpdateUser(_appUser);
      _navigationService.pushNamedAndRemoveUntil(AppRoutes.todos);
      // _navigationService.replaceWithTransition(const TodosView());
      _logger.i(_appUser);
      _snackbarService
          .registerSnackbarConfig(AppAssets.SUCCESS_SNACKBAR_CONFIG);
      _snackbarService.showSnackbar(
        title: 'Info',
        message: 'Registered successfully.',
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
      setBusyForObject(registerInProcess, false);
    }
  }
}
