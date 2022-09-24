import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../bloc/user_auth_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  bool _passwordHasError = true;
  bool _emailHasError = true;

  void _emailValidate() {
    setState(() {
      _emailHasError = !(_formKey.currentState?.fields['email']?.validate() ?? false);
    });
  }

  void _passwordValidate() {
    setState(() {
      _passwordHasError = !(_formKey.currentState?.fields['password']?.validate() ?? false);
    });
  }

  void _formValidate() {
    _emailValidate();
    _passwordValidate();
    _formKey.currentState!.saveAndValidate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: SizedBox(
          width: 260,
          child: FormBuilder(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FormBuilderTextField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  name: 'email',
                  initialValue: 'demo@domain.com',
                  decoration: InputDecoration(
                    labelText: 'Email',
                    suffixIcon: _emailHasError
                        ? const Icon(Icons.error, color: Colors.red)
                        : const Icon(Icons.check, color: Colors.green),
                  ),
                  validator: FormBuilderValidators.email(errorText: 'Введите валидный Email адрес'),
                  onChanged: (value) {
                    _emailValidate();
                  },
                ),
                FormBuilderTextField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  name: 'password',
                  initialValue: 'password',
                  decoration: InputDecoration(
                    labelText: 'Password',
                    suffixIcon: _passwordHasError
                        ? const Icon(Icons.error, color: Colors.red)
                        : const Icon(Icons.check, color: Colors.green),
                  ),
                  obscureText: true,
                  validator: (value) => (value ?? '').length < 6 ? 'Пароль слишком короткий.' : null,
                  onChanged: (value) {
                    _passwordValidate();
                  },
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  child: const Text('Войти', style: TextStyle(fontSize: 24.0)),
                  onTap: () {
                    _formValidate();
                    final emailField = _formKey.currentState!.fields['email'];
                    final passwordField = _formKey.currentState!.fields['password'];
                    if (emailField!.isValid && passwordField!.isValid) {
                      final userAuthBloc = context.read<UserAuthBloc>();
                      userAuthBloc.add(
                        UserAuthEvent.signIn(
                          emailField.value,
                          passwordField.value,
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
