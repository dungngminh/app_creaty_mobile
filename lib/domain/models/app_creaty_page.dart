import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'app_creaty_page.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class AppCreatyPage extends Equatable {
  AppCreatyPage({
    required this.pageName,
    required this.routeName,
    required this.data,
    String? id,
  }) : id = id ?? const Uuid().v4();

  factory AppCreatyPage.fromJson(Map<String, dynamic> json) =>
      _$AppCreatyPageFromJson(json);

  final String id;

  final String pageName;

  final String routeName;

  final Map<String, dynamic> data;

  @override
  List<Object?> get props => [
        id,
        pageName,
        routeName,
        data,
      ];

  Map<String, dynamic> toJson() => _$AppCreatyPageToJson(this);

  AppCreatyPage copyWith({
    String? id,
    String? pageName,
    String? routeName,
    Map<String, dynamic>? data,
  }) {
    return AppCreatyPage(
      id: id ?? this.id,
      pageName: pageName ?? this.pageName,
      routeName: routeName ?? this.routeName,
      data: data ?? this.data,
    );
  }
}
