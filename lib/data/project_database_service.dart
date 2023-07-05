import 'dart:developer';

import 'package:app_creaty_mobile/domain/models/app_creaty_creator.dart';
import 'package:app_creaty_mobile/domain/models/app_creaty_project.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProjectDatabaseService {
  ProjectDatabaseService({required SupabaseClient supabaseClient})
      : _supabaseClient = supabaseClient;

  static const _projectTable = 'projects';

  final SupabaseClient _supabaseClient;

  Future<List<AppCreatyProject>> getProjects(AppCreatyCreator user) async {
    log(user.toJson().toString());
    final results = await _supabaseClient
        .from(_projectTable)
        .select<List<Map<String, dynamic>>>();
    return results.map<AppCreatyProject>(AppCreatyProject.fromJson).toList();
  }

  Future<void> insertNewProject(AppCreatyProject project) =>
      _supabaseClient.from(_projectTable).insert(project.toJson());

  Future<void> updateProject(AppCreatyProject project) => _supabaseClient
      .from(_projectTable)
      .update(project.toJson())
      .eq('project_id', project.projectId);
}
