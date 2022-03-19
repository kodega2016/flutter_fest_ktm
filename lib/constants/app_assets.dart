import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class AppAssets {
  const AppAssets._();

  static SnackbarConfig get SUCCESS_SNACKBAR_CONFIG => SnackbarConfig(
        titleColor: Colors.white,
        messageColor: Colors.white,
        backgroundColor: Colors.green,
      );
  static SnackbarConfig get ERROR_SNACKBAR_CONFIG => SnackbarConfig(
        titleColor: Colors.white,
        messageColor: Colors.white,
        backgroundColor: Colors.red,
      );
}
