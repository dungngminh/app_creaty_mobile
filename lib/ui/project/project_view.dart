
import 'package:app_creaty_mobile/domain/models/app_creaty_project.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:json_widget/json_widget.dart' as json_widget;

class ProjectView extends StatelessWidget {
  const ProjectView({required this.project, super.key});

  final AppCreatyProject project;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Stack(
        children: [
          json_widget.FlutterWidget(
            widget: json_widget.Widget.fromJson(project.pages.first.data),
          ),
          SafeArea(
            child: IconButton.filledTonal(
              icon: const Icon(Icons.chevron_left),
              onPressed: () => context.pop(),
            ),
          )
        ],
      ),
    );
  }
}
