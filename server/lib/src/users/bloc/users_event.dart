part of 'users_bloc.dart';

abstract class UsersEvent extends Equatable {
  const UsersEvent();
}

class UserCreated extends UsersEvent {
  const UserCreated({required this.name});

  final String name;

  @override
  List<Object?> get props => [name];
}

class UserDeleted extends UsersEvent {
  const UserDeleted({required this.id});

  final int id;

  @override
  List<Object?> get props => [id];
}
