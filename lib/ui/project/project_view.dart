import 'package:app_creaty_mobile/domain/models/app_creaty_project.dart';
import 'package:flutter/material.dart';
import 'package:json_widget/json_widget.dart' as json_widget;

class ProjectView extends StatelessWidget {
  const ProjectView({required this.project, super.key});

  final AppCreatyProject project;

  @override
  Widget build(BuildContext context) {
    return json_widget.FlutterWidget(
      widget: json_widget.Widget.fromJson(project.pages.first.data),
    );
  }
}
