import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:app_creaty_mobile/commons/extensions/snack_bar_extension.dart';
import 'package:app_creaty_mobile/domain/repository/project_repository.dart';
import 'package:app_creaty_mobile/ui/app/app.dart';
import 'package:app_creaty_mobile/ui/auth/auth.dart';
import 'package:app_creaty_mobile/ui/auth/widgets/sign_out_dialog.dart';
import 'package:app_creaty_mobile/ui/home/cubit/home_cubit.dart';
import 'package:app_creaty_mobile/ui/home/cubit/home_state.dart';
import 'package:app_creaty_mobile/ui/project/project_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) => HomeCubit(
        projectRepository: context.read<ProjectRepository>(),
        appBloc: context.read<AppBloc>(),
      )..fetchProjectsOfUser(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with AfterLayoutMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Creaty'),
        actions: [
          BlocBuilder<AppBloc, AppState>(
            builder: (context, state) {
              if (state is Auth) {
                return IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () => showSignOutDialog<void>(context),
                );
              } else {
                return IconButton(
                  icon: const Icon(Icons.login),
                  onPressed: () => showAuthDialog<void>(context),
                );
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<HomeCubit>().fetchProjectsOfUser();
            },
          ),
        ],
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state.loadingStatus.isError) {
            return Center(
              child: IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  context.read<HomeCubit>().fetchProjectsOfUser();
                },
              ),
            );
          }
          if (state.projects.isEmpty) {
            return const Center(
              child: Text('No project here'),
            );
          }
          return RefreshIndicator(
            onRefresh: () async =>
                context.read<HomeCubit>().fetchProjectsOfUser(),
            child: Skeletonizer(
              enabled: state.loadingStatus.isLoading,
              child: ListView.builder(
                itemCount: state.projects.length,
                itemBuilder: (context, index) {
                  final project = state.projects[index];
                  return Padding(
                    padding: const EdgeInsets.all(8),
                    child: Card(
                      child: ListTile(
                        onTap: () {
                          if (project.pages.isEmpty) {
                            context.showSnackBar(
                              'Page is not designed, please design it',
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (context) => ProjectView(
                                  project: project,
                                ),
                              ),
                            );
                          }
                        },
                        title: Text(project.projectName),
                        subtitle: Text(project.createdBy.email ?? 'No info'),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    final state = context.read<AppBloc>().state;
    if ((state is Auth && state.user.isLocalhost) || state is UnAuth) {
      showAuthDialog<void>(context);
    }
  }
}
