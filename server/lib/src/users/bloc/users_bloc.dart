import 'package:broadcast_bloc/broadcast_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:users_api/api.dart';

part 'users_event.dart';
part 'users_state.dart';

/// Users Bloc
class UsersBloc extends BroadcastBloc<UsersEvent, UsersState> {
  /// Create an instance with an initial state of empty list of users
  UsersBloc() : super(const UsersState.initial()) {
    on<UserCreated>(_onUserCreated);
    on<UserDeleted>(_onUserDeleted);
  }

  /// Add user to the the current state
  Future<void> _onUserCreated(
    UserCreated event,
    Emitter<UsersState> emit,
  ) async {
    final users = List<User>.from(state.users);
    final name = event.name;
    final user = User(
      id: users.length.toString(),
      name: name,
      email: name,
    );
    users.add(user);
    emit(state.copyWith(users: users));
  }

  /// Remove user from the current state
  Future<void> _onUserDeleted(
    UserDeleted event,
    Emitter<UsersState> emit,
  ) async {
    final id = event.id;
    final users = state.users.where((user) => user.id != id).toList();
    emit(
      state.copyWith(
        users: users,
      ),
    );
  }

}
