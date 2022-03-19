import 'package:flutter_festival_ktm/app/app.locator.dart';

import 'mocks.dart';

void registerServices() {
  generateAndRegisterSnackbarServiceMock();
  generateAndRegisterNavigationServiceMock();
  generateAndRegisterFirebase();
  generateAndRegisterFirebaseAuth();
  generateAndRegisterFirebaseApp();
  generateAndRegisterFirebaseFirestore();
  generateAndRegisterAuthService();
  generateAndRegisterUserService();
  generateAndRegisterTodoService();
}

void unregisterServices() {
  unRegisterSnackbarServiceMock();
  unRegisterNavigationServiceMock();
  unRegisterFirebase();
  unRegisterFirebaseAuth();
  unRegisterFirebaseApp();
  unRegisterFirebaseFirestore();
  unRegisterAuthService();
  unRegisterUserService();
  unRegisterTodoService();
}

void removeRegistrationIfExists<T extends Object>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}
