// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_creaty_project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppCreatyProject _$AppCreatyProjectFromJson(Map<String, dynamic> json) =>
    AppCreatyProject(
      projectId: json['project_id'] as String,
      projectName: json['project_name'] as String,
      sourceCodePath: json['source_code_path'] as String,
      projectLogoAppImage: json['project_logo_app_image'] as String?,
      projectPreviewImage: json['project_preview_image'] as String?,
      createdBy: json['created_by'] == null
          ? null
          : AppCreatyCreator.fromJson(
              json['created_by'] as Map<String, dynamic>),
      pages: (json['pages'] as List<dynamic>?)
              ?.map((e) => AppCreatyPage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <AppCreatyPage>[],
      assets: (json['assets'] as List<dynamic>?)
              ?.map((e) => AppCreatyAsset.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <AppCreatyAsset>[],
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$AppCreatyProjectToJson(AppCreatyProject instance) =>
    <String, dynamic>{
      'project_id': instance.projectId,
      'project_name': instance.projectName,
      'project_preview_image': instance.projectPreviewImage,
      'project_logo_app_image': instance.projectLogoAppImage,
      'source_code_path': instance.sourceCodePath,
      'created_by': instance.createdBy.toJson(),
      'pages': instance.pages.map((e) => e.toJson()).toList(),
      'assets': instance.assets.map((e) => e.toJson()).toList(),
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
