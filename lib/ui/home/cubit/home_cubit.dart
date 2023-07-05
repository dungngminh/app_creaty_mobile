import 'dart:async';

import 'package:app_creaty_mobile/commons/enums/loading_status.dart';
import 'package:app_creaty_mobile/domain/models/app_creaty_creator.dart';
import 'package:app_creaty_mobile/domain/repository/project_repository.dart';
import 'package:app_creaty_mobile/ui/app/bloc/app_bloc.dart';
import 'package:app_creaty_mobile/ui/home/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required ProjectRepository projectRepository,
    required AppBloc appBloc,
  })  : _projectRepository = projectRepository,
        _appBloc = appBloc,
        super(const HomeState()) {
    appStateSubcription = appBloc.stream.distinct().listen((state) {
      if (state is Auth && !state.user.isLocalhost) {
        fetchProjectsOfUser(state.user);
      }
    });
  }

  final ProjectRepository _projectRepository;

  late final StreamSubscription<AppState> appStateSubcription;

  final AppBloc _appBloc;

  Future<void> fetchProjectsOfUser([AppCreatyCreator? creator]) async {
    if (_appBloc.state is! Auth) return;
    final authState = _appBloc.state as Auth;

    try {
      emit(state.copyWith(loadingStatus: LoadingStatus.loading));

      final projects =
          await _projectRepository.getProjectsByUser(creator ?? authState.user);
      emit(
        state.copyWith(
          loadingStatus: LoadingStatus.done,
          projects: projects,
        ),
      );
    } catch (e, s) {
      addError(e, s);
      emit(state.copyWith(loadingStatus: LoadingStatus.error));
    }
  }

  @override
  Future<void> close() {
    appStateSubcription.cancel();
    return super.close();
  }
}
