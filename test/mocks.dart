import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_festival_ktm/app/app.locator.dart';
import 'package:flutter_festival_ktm/services/auth_service.dart';
import 'package:flutter_festival_ktm/services/todo_service.dart';
import 'package:flutter_festival_ktm/services/user_service.dart';
import 'package:mockito/annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import 'mocks.mocks.dart';
import 'setup.dart';

@GenerateMocks(
  [
    Firebase,
    FirebaseApp,
    FirebaseAuth,
    FirebaseFirestore,
    User,
    UserCredential,
    CollectionReference,
    DocumentReference,
    SnackbarService,
    NavigationService,
    AuthService,
    UserService,
    TodoService,
  ],
  customMocks: [],
)
void main() {}

//Snackbar Service
SnackbarService generateAndRegisterSnackbarServiceMock() {
  final instance = MockSnackbarService();
  removeRegistrationIfExists<SnackbarService>();
  locator.registerLazySingleton<SnackbarService>(() => instance);
  return instance;
}

void unRegisterSnackbarServiceMock() {
  locator.unregister<SnackbarService>();
}

//Navigation Service
NavigationService generateAndRegisterNavigationServiceMock() {
  final instance = MockNavigationService();
  removeRegistrationIfExists<NavigationService>();
  locator.registerLazySingleton<NavigationService>(() => instance);
  return instance;
}

void unRegisterNavigationServiceMock() {
  locator.unregister<NavigationService>();
}

// Firebase App
MockFirebaseApp generateAndRegisterFirebaseApp() {
  final instance = MockFirebaseApp();
  removeRegistrationIfExists<FirebaseApp>();
  locator.registerLazySingleton<FirebaseApp>(() => instance);
  return instance;
}

void unRegisterFirebaseApp() {
  locator.unregister<FirebaseApp>();
}

//Firestore Database
MockFirebaseFirestore generateAndRegisterFirebaseFirestore() {
  final instance = MockFirebaseFirestore();
  removeRegistrationIfExists<FirebaseFirestore>();
  locator.registerLazySingleton<FirebaseFirestore>(() => instance);
  return instance;
}

void unRegisterFirebaseFirestore() {
  locator.unregister<FirebaseFirestore>();
}

//Firebase

MockFirebase generateAndRegisterFirebase() {
  final instance = MockFirebase();
  removeRegistrationIfExists<Firebase>();
  locator.registerLazySingleton<Firebase>(() => instance);
  return instance;
}

void unRegisterFirebase() {
  locator.unregister<Firebase>();
}

//Firebase Auth
MockFirebaseAuth generateAndRegisterFirebaseAuth() {
  final instance = MockFirebaseAuth();
  removeRegistrationIfExists<FirebaseAuth>();
  locator.registerLazySingleton<FirebaseAuth>(() => instance);
  return instance;
}

void unRegisterFirebaseAuth() {
  locator.unregister<FirebaseAuth>();
}

//UserService
MockUserService generateAndRegisterUserService() {
  final instance = MockUserService();
  removeRegistrationIfExists<UserService>();
  locator.registerLazySingleton<UserService>(() => instance);
  return instance;
}

void unRegisterUserService() {
  locator.unregister<UserService>();
}

//AuthService
MockAuthService generateAndRegisterAuthService() {
  final instance = MockAuthService();
  removeRegistrationIfExists<AuthService>();
  locator.registerLazySingleton<AuthService>(() => instance);
  return instance;
}

void unRegisterAuthService() {
  locator.unregister<AuthService>();
}

//TodoService
MockTodoService generateAndRegisterTodoService() {
  final instance = MockTodoService();
  removeRegistrationIfExists<TodoService>();
  locator.registerLazySingleton<TodoService>(() => instance);
  return instance;
}

void unRegisterTodoService() {
  locator.unregister<TodoService>();
}
