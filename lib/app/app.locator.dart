// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../services/auth_service.dart';
import '../services/todo_service.dart';
import '../services/user_service.dart';
import '../ui/login/login_view_model.dart';
import '../ui/register/register_view_model.dart';
import '../ui/startup/startup_view_model.dart';
import '../ui/todo_form/todo_form_view_model.dart';
import '../ui/todos/todos_view_model.dart';
import 'init_config.dart';

final locator = StackedLocator.instance;

void setupLocator({String? environment, EnvironmentFilter? environmentFilter}) {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  locator.registerSingleton(NavigationService());
  locator.registerLazySingleton(() => SnackbarService());
  locator.registerLazySingleton(() => BottomSheetService());
  locator.registerLazySingleton<FirebaseAuth>(
      () => InitConfig.getFirebaseAuthInstance());
  locator.registerLazySingleton<FirebaseFirestore>(
      () => InitConfig.getFirebaseFireStoreInstance());
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => UserService());
  locator.registerLazySingleton(() => TodoService());
  locator.registerFactory(() => StartUpViewModel());
  locator.registerFactory(() => RegisterViewModel());
  locator.registerFactory(() => LoginViewModel());
  locator.registerFactory(() => TodosViewModel());
  locator.registerFactory(() => TodoFormViewModel());
}
