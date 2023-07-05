import 'package:app_creaty_mobile/domain/models/app_creaty_asset.dart';
import 'package:app_creaty_mobile/domain/models/app_creaty_creator.dart';
import 'package:app_creaty_mobile/domain/models/app_creaty_page.dart';
import 'package:dartx/dartx.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'app_creaty_project.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class AppCreatyProject extends Equatable {
  AppCreatyProject({
    required this.projectId,
    required this.projectName,
    required this.sourceCodePath,
    this.projectLogoAppImage,
    this.projectPreviewImage,
    AppCreatyCreator? createdBy,
    this.pages = const <AppCreatyPage>[],
    this.assets = const <AppCreatyAsset>[],
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now(),
        createdBy = createdBy ?? AppCreatyCreator.local();

  factory AppCreatyProject.fromJson(Map<String, dynamic> json) =>
      _$AppCreatyProjectFromJson(json);

  final String projectId;
  final String projectName;
  final String? projectPreviewImage;
  final String? projectLogoAppImage;
  final String sourceCodePath;
  final AppCreatyCreator createdBy;
  final List<AppCreatyPage> pages;
  final List<AppCreatyAsset> assets;
  final DateTime createdAt;
  final DateTime updatedAt;

  String get projectFullPath => sourceCodePath.removeSuffix('/source_code');

  Map<String, dynamic> toJson() => _$AppCreatyProjectToJson(this);

  @override
  List<Object?> get props {
    return [
      projectId,
      projectName,
      projectPreviewImage,
      projectLogoAppImage,
      sourceCodePath,
      createdBy,
      pages,
      assets,
      createdAt,
      updatedAt,
    ];
  }

  AppCreatyProject copyWith({
    String? projectId,
    String? projectName,
    String? projectPreviewImage,
    String? projectLogoAppImage,
    String? sourceCodePath,
    AppCreatyCreator? createdBy,
    List<AppCreatyPage>? pages,
    List<AppCreatyAsset>? assets,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AppCreatyProject(
      projectId: projectId ?? this.projectId,
      projectName: projectName ?? this.projectName,
      projectPreviewImage: projectPreviewImage ?? this.projectPreviewImage,
      projectLogoAppImage: projectLogoAppImage ?? this.projectLogoAppImage,
      sourceCodePath: sourceCodePath ?? this.sourceCodePath,
      createdBy: createdBy ?? this.createdBy,
      pages: pages ?? this.pages,
      assets: assets ?? this.assets,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
