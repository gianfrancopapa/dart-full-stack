part of 'users_bloc.dart';

enum UsersStatus {
  initial,
  loading,
  loaded,
  error,
}

class UsersState extends Equatable {
  const UsersState({
    required this.users,
    required this.status,
  });

  const UsersState.initial()
      : this(
          users: const [],
          status: UsersStatus.initial,
        );

  final List<User> users;
  final UsersStatus status;

  UsersState copyWith({
    List<User>? users,
    UsersStatus? status,
  }) {
    return UsersState(
      users: users ?? this.users,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [users, status];
}
