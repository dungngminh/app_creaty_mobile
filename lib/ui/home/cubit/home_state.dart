import 'package:app_creaty_mobile/commons/enums/loading_status.dart';
import 'package:app_creaty_mobile/domain/models/app_creaty_project.dart';
import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  const HomeState({
    this.projects = const <AppCreatyProject>[],
    this.loadingStatus = LoadingStatus.initial,
  });
  final List<AppCreatyProject> projects;
  final LoadingStatus loadingStatus;

  @override
  List<Object> get props => [projects, loadingStatus];

  HomeState copyWith({
    List<AppCreatyProject>? projects,
    LoadingStatus? loadingStatus,
  }) {
    return HomeState(
      projects: projects ?? this.projects,
      loadingStatus: loadingStatus ?? this.loadingStatus,
    );
  }
}
