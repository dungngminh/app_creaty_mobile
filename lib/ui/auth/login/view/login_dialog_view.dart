import 'dart:async';

import 'package:app_creaty_mobile/commons/enums/validation_error.dart';
import 'package:app_creaty_mobile/commons/extensions/snack_bar_extension.dart';
import 'package:app_creaty_mobile/commons/extensions/theme_extension.dart';
import 'package:app_creaty_mobile/ui/auth/login/cubit/login_cubit.dart';
import 'package:app_creaty_mobile/ui/auth/login/cubit/login_state.dart';
import 'package:app_creaty_mobile/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:rxdart_ext/rxdart_ext.dart';
import 'package:string_validator/string_validator.dart';

class LoginDialogView extends StatefulWidget {
  const LoginDialogView({
    required this.onRegisterButtonPressed,
    super.key,
  });

  final VoidCallback onRegisterButtonPressed;

  @override
  State<LoginDialogView> createState() => _LoginDialogViewState();
}

class _LoginDialogViewState extends State<LoginDialogView> {
  late final TextEditingController emailEditingController =
      TextEditingController();
  late final TextEditingController passwordEditingController =
      TextEditingController();

  late final StreamController<ValidationError?> emailValidationStream =
      StreamController.broadcast(sync: true);
  late final StreamController<ValidationError?> passwordValidationStream =
      StreamController.broadcast(sync: true);

  @override
  void initState() {
    super.initState();
    emailEditingController.addListener(bindEmailEditingListener);
    passwordEditingController.addListener(bindPasswordEditingListener);
  }

  void bindEmailEditingListener() {
    final emailValue = emailEditingController.text;
    if (emailValue.isEmpty) {
      emailValidationStream.add(ValidationError.empty);
    } else if (!isEmail(emailValue)) {
      emailValidationStream.add(ValidationError.notValid);
    } else {
      emailValidationStream.add(null);
    }
  }

  void bindPasswordEditingListener() {
    final passwordValue = passwordEditingController.text;

    if (passwordValue.isEmpty) {
      passwordValidationStream.add(ValidationError.empty);
    } else if (passwordValue.length < 8) {
      passwordValidationStream.add(ValidationError.tooShort);
    } else {
      passwordValidationStream.add(null);
    }
  }

  void onLoginPressed() {
    final emailValue = emailEditingController.text.trim();
    final passwordValue = passwordEditingController.text.trim();

    context
        .read<LoginCubit>()
        .login(email: emailValue, password: passwordValue);
  }

  @override
  void dispose() {
    emailValidationStream.close();
    passwordValidationStream.close();
    emailEditingController.dispose();
    passwordEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const gap16 = Gap(16);
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (previous, current) => previous != current,
      listener: (context, state) {
        if (state.loadingStatus.isDone) {
          context
            ..pop()
            ..showSnackBar('Login successfully');
        }
      },
      child: Center(
        child: SizedBox(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Login',
                    style: context.textTheme.titleLarge,
                  ),
                  gap16,
                  StreamBuilder<ValidationError?>(
                    stream: emailValidationStream.stream.distinct(),
                    builder: (context, snapshot) {
                      final errorType = snapshot.data;
                      return AppTextField(
                        labelText: 'Email',
                        controller: emailEditingController,
                        errorText: switch (errorType) {
                          ValidationError.empty => 'Please input email',
                          ValidationError.notValid => 'Email is not valid',
                          _ => null,
                        },
                      );
                    },
                  ),
                  gap16,
                  StreamBuilder<ValidationError?>(
                    stream: passwordValidationStream.stream.distinct(),
                    builder: (context, snapshot) {
                      final errorType = snapshot.data;
                      return AppTextField(
                        labelText: 'Password',
                        controller: passwordEditingController,
                        obscureText: true,
                        errorText: switch (errorType) {
                          ValidationError.empty => 'Please input password',
                          ValidationError.tooShort => 'Password is too short',
                          _ => null,
                        },
                      );
                    },
                  ),
                  gap16,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Builder(
                        builder: (context) {
                          final loadingStatus =
                              context.watch<LoginCubit>().state.loadingStatus;

                          return Visibility(
                            visible: loadingStatus.isError,
                            child: const Text('Login error'),
                          );
                        },
                      ),
                      TextButton(
                        onPressed: widget.onRegisterButtonPressed,
                        child: const Text('Register?'),
                      )
                    ],
                  ),
                  gap16,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,

                    children: [
                      Row(
                        children: [
                          StreamBuilder(
                            stream: Rx.combineLatest2(
                              emailValidationStream.stream,
                              passwordValidationStream.stream,
                              (a, b) => [a, b].every((value) => value == null),
                            ),
                            builder: (context, value) {
                              final loadingStatus = context
                                  .watch<LoginCubit>()
                                  .state
                                  .loadingStatus;
                              if (loadingStatus.isLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return FilledButton(
                                onPressed:
                                    value.data == false || value.data == null
                                        ? null
                                        : onLoginPressed,
                                child: const Text('Login'),
                              );
                            },
                          ),
                          const Gap(8),
                          TextButton(
                            child: const Text('Cancel'),
                            onPressed: () => context.pop(),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
