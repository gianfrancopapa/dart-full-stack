import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

/// {@template user}
/// A User object
/// {@endtemplate}
@JsonSerializable()
class User extends Equatable {
  /// {@macro user}
  const User({
    required this.id,
    required this.name,
    required this.email,
  });

  /// An instance of an empty [User]
  const User.empty() : this(id: 1, name: '', email: '');

  /// Deserializes the given `Map<String, dynamic>` into a [User].
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// User identifier
  final int id;

  /// User name
  final String name;

  /// User email
  final String email;

  /// Serializes the given [User] into a `Map<String, dynamic>`
  Map<String, dynamic> toJson() => _$UserToJson(this);

  /// Returns a copy of a [User] using the given values
  User copyWith({
    int? id,
    String? name,
    String? email,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
      );

  @override
  List<Object?> get props => [id, name, email];
}
