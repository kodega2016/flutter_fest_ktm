import 'dart:async';

import 'package:firebase_helpers/firebase_helpers.dart';
import 'package:flutter_festival_ktm/app/app.locator.dart';
import 'package:flutter_festival_ktm/app/app.logger.dart';
import 'package:flutter_festival_ktm/app/app.router.dart';
import 'package:flutter_festival_ktm/constants/app_assets.dart';
import 'package:flutter_festival_ktm/constants/app_routes.dart';
import 'package:flutter_festival_ktm/constants/app_strings.dart';
import 'package:flutter_festival_ktm/data/models/todo/todo.dart';
import 'package:flutter_festival_ktm/services/auth_service.dart';
import 'package:flutter_festival_ktm/services/todo_service.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class TodosViewModel extends BaseViewModel {
  final TodoService _todoService = locator<TodoService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthService _authService = locator<AuthService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();
  final Logger _logger = getLogger('LoginViewModel');

  List<Todo> _todos = <Todo>[];
  List<Todo> get todos => _todos;

  StreamSubscription? _todosSubscription;

  void init() {
    streamTodos();
  }

  Future<void> logout() async {
    try {
      await _authService.signOut();
      _navigationService.pushNamedAndRemoveUntil(AppRoutes.login);
    } catch (e) {
      _logger.e(e);
    }
  }

  void streamTodos() {
    final _snaps = _todoService.todoDB.streamQueryList(
      args: [
        QueryArgsV2('userId', isEqualTo: _authService.currentUser!.id),
      ],
    );
    _todosSubscription = _snaps.listen((event) {
      _todos = event;
      notifyListeners();
    });
  }

  void navigateToTodoForm({Todo? todo}) {
    _navigationService.navigateTo(
      AppRoutes.todoForm,
      arguments: TodoFormViewArguments(
        todo: todo,
      ),
    );
  }

  void navigateToTodo({required Todo todo}) {
    _navigationService.navigateTo(
      AppRoutes.todo,
      arguments: TodoViewArguments(
        todo: todo,
      ),
    );
  }

  void deleteTodo(String id) {
    try {
      _todoService.deleteTodo(id);
      _navigationService.back();
      _snackbarService
          .registerSnackbarConfig(AppAssets.SUCCESS_SNACKBAR_CONFIG);
      _snackbarService.showSnackbar(
        title: AppString.info,
        message: AppString.todoDeleted,
      );
    } catch (e) {
      _snackbarService.registerSnackbarConfig(AppAssets.ERROR_SNACKBAR_CONFIG);
      _snackbarService.showSnackbar(
        title: AppString.info,
        message: e.toString(),
      );
    }
  }

  @override
  void dispose() {
    _todosSubscription?.cancel();
    super.dispose();
  }
}
