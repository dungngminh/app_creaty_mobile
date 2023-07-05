import 'package:app_creaty_mobile/commons/gen/fonts.gen.dart';
import 'package:app_creaty_mobile/commons/router/app_router.dart';
import 'package:app_creaty_mobile/commons/theme/app_text_theme.dart';
import 'package:app_creaty_mobile/data/auth_service.dart';
import 'package:app_creaty_mobile/data/project_database_service.dart';
import 'package:app_creaty_mobile/domain/repository/auth_repository.dart';
import 'package:app_creaty_mobile/domain/repository/project_repository.dart';
import 'package:app_creaty_mobile/ui/app/app.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Application extends StatefulWidget {
  const Application({required this.supabaseClient, super.key});

  final SupabaseClient supabaseClient;

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) =>
              AuthService(supabaseAuth: widget.supabaseClient.auth),
        ),
        RepositoryProvider(
          create: (context) =>
              ProjectDatabaseService(supabaseClient: widget.supabaseClient),
        ),
        RepositoryProvider<AuthRepository>(
          create: (context) =>
              AuthRepositoryImpl(authService: context.read<AuthService>()),
        ),
        RepositoryProvider<ProjectRepository>(
          create: (context) => ProjectRepository(
            databaseService: context.read<ProjectDatabaseService>(),
          ),
        ),
      ],
      child: Builder(
        builder: (context) {
          return BlocProvider<AppBloc>(
            create: (context) => AppBloc(
              authRepository: context.read<AuthRepository>(),
            ),
            child: MaterialApp.router(
              routeInformationParser: AppRouter.router.routeInformationParser,
              routeInformationProvider:
                  AppRouter.router.routeInformationProvider,
              routerDelegate: AppRouter.router.routerDelegate,
              title: 'App Creaty',
              debugShowCheckedModeBanner: false,
              theme: FlexThemeData.light(
                scheme: FlexScheme.blue,
                useMaterial3: true,
                useMaterial3ErrorColors: true,
                textTheme: AppTextTheme().textTheme,
                fontFamily: FontFamily.nunito,
              ),
              darkTheme: FlexThemeData.light(
                scheme: FlexScheme.blue,
                useMaterial3: true,
                useMaterial3ErrorColors: true,
                textTheme: AppTextTheme().textTheme,
                fontFamily: FontFamily.nunito,
              ),
            ),
          );
        },
      ),
    );
  }
}
