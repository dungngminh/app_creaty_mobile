import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'app_creaty_creator.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AppCreatyCreator extends Equatable {
  const AppCreatyCreator({
    required this.id,
    required this.name,
    required this.email,
  });

  factory AppCreatyCreator.local() {
    return const AppCreatyCreator(
      id: 'localhost',
      name: 'Localhost',
      email: null,
    );
  }

  factory AppCreatyCreator.fromJson(Map<String, dynamic> json) =>
      _$AppCreatyCreatorFromJson(json);

  final String id;
  final String name;
  final String? email;

  bool get isLocalhost => id == 'localhost';

  Map<String, dynamic> toJson() => _$AppCreatyCreatorToJson(this);

  @override
  List<Object?> get props => [id, name, email];
}
