part of 'users_bloc.dart';

abstract class UsersEvent extends Equatable {
  const UsersEvent();
}

class UsersFetched extends UsersEvent {
  const UsersFetched({required this.users});

  final List<User> users;

  @override
  List<Object?> get props => [users];
}
