import 'dart:async';

import 'package:flutter_festival_ktm/app/app.locator.dart';
import 'package:flutter_festival_ktm/app/app.logger.dart';
import 'package:flutter_festival_ktm/constants/app_assets.dart';
import 'package:flutter_festival_ktm/constants/app_routes.dart';
import 'package:flutter_festival_ktm/constants/app_strings.dart';
import 'package:flutter_festival_ktm/data/models/todo/todo.dart';
import 'package:flutter_festival_ktm/services/auth_service.dart';
import 'package:flutter_festival_ktm/services/todo_service.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class TodoFormViewModel extends BaseViewModel {
  final TodoService _todoService = locator<TodoService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthService _authService = locator<AuthService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();
  final Logger _logger = getLogger('LoginViewModel');

  static const String saving = 'saving';

  String? _id;
  String? _title;
  String? _description;
  bool _isCompleted = false;

  String? get title => _title;
  String? get description => _description;
  bool get isCompleted => _isCompleted;

  Future<void> logout() async {
    try {
      await _authService.signOut();
      _navigationService.pushNamedAndRemoveUntil(AppRoutes.login);
    } catch (e) {
      _logger.e(e);
    }
  }

  void changeTitle(String? val) {
    _title = val;
    notifyListeners();
  }

  void changeDescription(String? val) {
    _description = val;
    notifyListeners();
  }

  void changeStatus(bool val) {
    _isCompleted = val;
    notifyListeners();
  }

  bool get isFormValid =>
      (_title?.isNotEmpty ?? false) && (_description?.isNotEmpty ?? false);

  Future<void> save({bool isEdting = false}) async {
    try {
      setBusyForObject(saving, true);

      final _isEdited = _id != null;

      final _todo = Todo(
        id: _id ?? DateTime.now().toIso8601String(),
        userId: _authService.currentUser!.id,
        title: _title!,
        description: _description!,
        isComplete: _isCompleted,
      );

      await _todoService.createOrUpdateTodo(_todo.toJson(), _todo.id);
      _navigationService.back();
      _snackbarService.registerSnackbarConfig(
        AppAssets.SUCCESS_SNACKBAR_CONFIG,
      );
      _snackbarService.showSnackbar(
        message: _isEdited ? AppString.todoUpdated : AppString.todoCreated,
        title: AppString.info,
      );
    } catch (e) {
      _logger.e(e);
      _snackbarService.registerSnackbarConfig(
        AppAssets.ERROR_SNACKBAR_CONFIG,
      );
      _snackbarService.showSnackbar(
        message: e.toString(),
        title: AppString.info,
      );
    } finally {
      setBusyForObject(saving, false);
    }
  }

  init(Todo? todo) {
    _id = todo?.id;
    _title = todo?.title;
    _description = todo?.description;
    _isCompleted = todo?.isComplete ?? false;
    notifyListeners();
  }
}
