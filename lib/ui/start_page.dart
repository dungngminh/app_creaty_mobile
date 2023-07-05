import 'package:app_creaty_mobile/ui/app/app.dart';
import 'package:app_creaty_mobile/ui/home/view/home_page.dart';
import 'package:app_creaty_mobile/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppBloc>().state;
    final loadingView = Scaffold(
      body: const Center(
        child: LoadingView(),
      )
          .animate()
          .fadeIn(duration: 500.ms)
          .then(delay: 5.seconds)
          .fadeOut(duration: 500.ms),
    );
    final homeView = const HomePage().animate().fade(duration: 500.ms);
    return appState.maybeWhen(
      loading: () => loadingView,
      auth: (_) => homeView,
      unAuth: () => homeView,
      orElse: Scaffold.new,
    );
  }
}
