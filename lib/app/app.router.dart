// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../data/models/todo/todo.dart';
import '../ui/login/login_view.dart';
import '../ui/register/register_view.dart';
import '../ui/startup/startup_view.dart';
import '../ui/todo/todo_view.dart';
import '../ui/todo_form/todo_from_view.dart';
import '../ui/todos/todos_view.dart';

class Routes {
  static const String startupView = '/';
  static const String loginView = '/login';
  static const String registerView = '/register';
  static const String todosView = '/todos';
  static const String todoView = '/todo';
  static const String todoFormView = '/todo-form';
  static const all = <String>{
    startupView,
    loginView,
    registerView,
    todosView,
    todoView,
    todoFormView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.startupView, page: StartupView),
    RouteDef(Routes.loginView, page: LoginView),
    RouteDef(Routes.registerView, page: RegisterView),
    RouteDef(Routes.todosView, page: TodosView),
    RouteDef(Routes.todoView, page: TodoView),
    RouteDef(Routes.todoFormView, page: TodoFormView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    StartupView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const StartupView(),
        settings: data,
      );
    },
    LoginView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const LoginView(),
        settings: data,
      );
    },
    RegisterView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const RegisterView(),
        settings: data,
      );
    },
    TodosView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const TodosView(),
        settings: data,
      );
    },
    TodoView: (data) {
      var args = data.getArgs<TodoViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => TodoView(
          key: args.key,
          todo: args.todo,
        ),
        settings: data,
      );
    },
    TodoFormView: (data) {
      var args = data.getArgs<TodoFormViewArguments>(
        orElse: () => TodoFormViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => TodoFormView(
          key: args.key,
          todo: args.todo,
        ),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// TodoView arguments holder class
class TodoViewArguments {
  final Key? key;
  final Todo todo;
  TodoViewArguments({this.key, required this.todo});
}

/// TodoFormView arguments holder class
class TodoFormViewArguments {
  final Key? key;
  final Todo? todo;
  TodoFormViewArguments({this.key, this.todo});
}
