import 'package:flutter_festival_ktm/app/app.locator.dart';
import 'package:flutter_festival_ktm/app/app.logger.dart';
import 'package:flutter_festival_ktm/services/auth_service.dart';
import 'package:flutter_festival_ktm/services/user_service.dart';
import 'package:flutter_festival_ktm/ui/login/login_view.dart';
import 'package:flutter_festival_ktm/ui/todos/todos_view.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartUpViewModel extends BaseViewModel {
  final AuthService _authService = locator<AuthService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final UserService _userService = locator<UserService>();
  final Logger _logger = getLogger('StartUpViewModel');

  Future<void> init() async {
    await _checkUser();
  }

  Future<void> _checkUser() async {
    try {
      final _user = _authService.currentUser;
      await Future.delayed(Duration.zero);
      if (_user == null) {
        _navigationService.replaceWithTransition(const LoginView());
      } else {
        _logger.i('Already exists.Update user.');
        await _userService.createOrUpdateUser(_user);
        _navigationService.replaceWithTransition(const TodosView());
      }
    } catch (e) {
      _logger.e(e);
    }
  }
}
