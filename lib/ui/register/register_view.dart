import 'package:flutter/material.dart';
import 'package:flutter_festival_ktm/app/app.locator.dart';
import 'package:flutter_festival_ktm/ui/register/register_view_model.dart';
import 'package:flutter_festival_ktm/widgets/p_elevated_button.dart';
import 'package:stacked/stacked.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: ViewModelBuilder<RegisterViewModel>.reactive(
        viewModelBuilder: () => locator<RegisterViewModel>(),
        builder: (context, model, child) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      onChanged: model.changeName,
                      decoration: const InputDecoration(
                        labelText: 'Full name',
                      ),
                    ),
                    TextField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: model.changeEmail,
                      decoration: const InputDecoration(
                        labelText: 'Email address',
                      ),
                    ),
                    TextField(
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                      onChanged: model.changePassword,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                      ),
                    ),
                    const SizedBox(height: 10),
                    PElevatedButton(
                      isBusy: model.busy(RegisterViewModel.registerInProcess),
                      onPressed: () async => await model.register(),
                      label: 'Register',
                      disable: !model.isFormValid,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
