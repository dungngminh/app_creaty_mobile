// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_creaty_page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppCreatyPage _$AppCreatyPageFromJson(Map<String, dynamic> json) =>
    AppCreatyPage(
      pageName: json['page_name'] as String,
      routeName: json['route_name'] as String,
      data: json['data'] as Map<String, dynamic>,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$AppCreatyPageToJson(AppCreatyPage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'page_name': instance.pageName,
      'route_name': instance.routeName,
      'data': instance.data,
    };
