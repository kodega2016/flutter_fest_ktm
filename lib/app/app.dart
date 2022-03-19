import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_festival_ktm/app/init_config.dart';
import 'package:flutter_festival_ktm/constants/app_routes.dart';
import 'package:flutter_festival_ktm/services/auth_service.dart';
import 'package:flutter_festival_ktm/services/todo_service.dart';
import 'package:flutter_festival_ktm/services/user_service.dart';
import 'package:flutter_festival_ktm/ui/login/login_view.dart';
import 'package:flutter_festival_ktm/ui/login/login_view_model.dart';
import 'package:flutter_festival_ktm/ui/register/register_view.dart';
import 'package:flutter_festival_ktm/ui/register/register_view_model.dart';
import 'package:flutter_festival_ktm/ui/startup/startup_view.dart';
import 'package:flutter_festival_ktm/ui/startup/startup_view_model.dart';
import 'package:flutter_festival_ktm/ui/todo/todo_view.dart';
import 'package:flutter_festival_ktm/ui/todo_form/todo_form_view_model.dart';
import 'package:flutter_festival_ktm/ui/todo_form/todo_from_view.dart';
import 'package:flutter_festival_ktm/ui/todos/todos_view.dart';
import 'package:flutter_festival_ktm/ui/todos/todos_view_model.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  logger: StackedLogger(),
  routes: [
    MaterialRoute(
      page: StartupView,
      path: AppRoutes.startUp,
      initial: true,
    ),
    MaterialRoute(
      page: LoginView,
      path: AppRoutes.login,
    ),
    MaterialRoute(
      page: RegisterView,
      path: AppRoutes.register,
    ),
    MaterialRoute(
      page: TodosView,
      path: AppRoutes.todos,
    ),
    MaterialRoute(
      page: TodoView,
      path: AppRoutes.todo,
    ),
    MaterialRoute(
      page: TodoFormView,
      path: AppRoutes.todoForm,
    ),
  ],
  dependencies: [
    Singleton(
      classType: NavigationService,
    ),
    LazySingleton(
      classType: SnackbarService,
    ),
    LazySingleton(
      classType: BottomSheetService,
    ),
    LazySingleton(
      asType: FirebaseAuth,
      classType: InitConfig,
      resolveUsing: InitConfig.getFirebaseAuthInstance,
    ),
    LazySingleton(
      asType: FirebaseFirestore,
      classType: InitConfig,
      resolveUsing: InitConfig.getFirebaseFireStoreInstance,
    ),
    LazySingleton(
      classType: AuthService,
    ),
    LazySingleton(
      classType: UserService,
    ),
    LazySingleton(
      classType: TodoService,
    ),
    Factory(
      classType: StartUpViewModel,
    ),
    Factory(
      classType: RegisterViewModel,
    ),
    Factory(
      classType: LoginViewModel,
    ),
    Factory(
      classType: TodosViewModel,
    ),
    Factory(
      classType: TodoFormViewModel,
    ),
  ],
)
class App {
  /** This class has no puporse besides housing the annotation that generates the required functionality **/
}
