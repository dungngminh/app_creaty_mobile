import 'package:app_creaty_mobile/data/project_database_service.dart';
import 'package:app_creaty_mobile/domain/models/app_creaty_creator.dart';
import 'package:app_creaty_mobile/domain/models/app_creaty_project.dart';

class ProjectRepository {
  ProjectRepository({required ProjectDatabaseService databaseService})
      : _databaseService = databaseService;
  final ProjectDatabaseService _databaseService;

  Future<List<AppCreatyProject>> getProjectsByUser(AppCreatyCreator creator) =>
      _databaseService.getProjects(creator);
}
