import 'package:flutter/material.dart';
import 'package:flutter_festival_ktm/app/app.locator.dart';
import 'package:flutter_festival_ktm/ui/startup/startup_view_model.dart';
import 'package:stacked/stacked.dart';

class StartupView extends StatelessWidget {
  const StartupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ViewModelBuilder<StartUpViewModel>.reactive(
        viewModelBuilder: () => locator<StartUpViewModel>(),
        onModelReady: (model) async => await model.init(),
        builder: (context, model, child) {
          return const Scaffold();
        },
      ),
    );
  }
}
