import 'package:app_creaty_mobile/ui/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

Future<T?> showSignOutDialog<T>(BuildContext context) {
  return showDialog(
    context: context,
    builder: (_) {
      return SignOutDialog(
        onConfirmLogoutPressed: () => context
          ..read<AppBloc>().add(const ChangeUser(user: null))
          ..pop(),
      );
    },
  );
}

class SignOutDialog extends StatelessWidget {
  const SignOutDialog({required this.onConfirmLogoutPressed, super.key});

  final VoidCallback onConfirmLogoutPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Log out'),
      content: const Text('Are you sure to logout'),
      actions: [
        FilledButton(
          onPressed: onConfirmLogoutPressed,
          child: const Text('Yes'),
        ),
        TextButton(
          onPressed: () {
            context.pop();
          },
          child: const Text('No'),
        )
      ],
    );
  }
}
