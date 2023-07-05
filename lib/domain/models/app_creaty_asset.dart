import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'app_creaty_asset.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class AppCreatyAsset extends Equatable {
  AppCreatyAsset({
    required this.assetName,
    required this.relativePath,
    String? id,
  }) : id = id ?? const Uuid().v4();

  factory AppCreatyAsset.fromJson(Map<String, dynamic> json) =>
      _$AppCreatyAssetFromJson(json);

  final String id;
  final String assetName;
  final String relativePath;

  @override
  List<Object?> get props => [id, assetName, relativePath];

  Map<String, dynamic> toJson() => _$AppCreatyAssetToJson(this);
}
