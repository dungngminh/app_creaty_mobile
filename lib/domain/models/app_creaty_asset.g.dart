// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_creaty_asset.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppCreatyAsset _$AppCreatyAssetFromJson(Map<String, dynamic> json) =>
    AppCreatyAsset(
      assetName: json['asset_name'] as String,
      relativePath: json['relative_path'] as String,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$AppCreatyAssetToJson(AppCreatyAsset instance) =>
    <String, dynamic>{
      'id': instance.id,
      'asset_name': instance.assetName,
      'relative_path': instance.relativePath,
    };
