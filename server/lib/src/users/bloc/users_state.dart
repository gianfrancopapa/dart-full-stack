part of 'users_bloc.dart';

/// Users State
class UsersState extends Equatable {
  /// Create an instance of Users State
  const UsersState({
    required this.users,
  });

  /// Create an instance of initial Users State
  const UsersState.initial()
      : this(
          users: const [],
        );

  /// The list of users
  final List<User> users;

  /// Create an instance with a copy of Users State
  UsersState copyWith({
    List<User>? users,
  }) {
    return UsersState(
      users: users ?? this.users,
    );
  }

  @override
  List<Object> get props => [users];

  @override
  String toString() {
    final newUsers =
        users.map((user) => jsonEncode(user.toJson())).toList();
    return newUsers.toString();
  }
}
