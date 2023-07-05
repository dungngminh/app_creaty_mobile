import 'package:app_creaty_mobile/app_bloc_observer.dart';
import 'package:app_creaty_mobile/application.dart';
import 'package:app_creaty_mobile/env.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {

  await Supabase.initialize(
    url: Env.supabaseUrl,
    anonKey: Env.supabaseAnon,
  );
  final supabase = Supabase.instance.client;
  Bloc.observer = AppBlocObserver();

  runApp(Application(supabaseClient: supabase));
}
