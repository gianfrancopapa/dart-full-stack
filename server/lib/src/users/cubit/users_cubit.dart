import 'package:broadcast_bloc/broadcast_bloc.dart';
import 'package:users_api/api.dart';

/// Users Cubit
class UsersCubit extends BroadcastCubit<List<User>> {
  /// Create an instance with an initial state of empty list of users.
  UsersCubit() : super([]);

  /// Add user to the the current state.
  void addUser(String name) {
    final users = List<User>.from(state);
    final user = User(id: 1, name: name, email: name);
    users.add(user);
    emit(users);
  }

  /// Remove user from the current state.
  void removeUser(String name) {
    final users = state.where((user) => user.name != name).toList();
    emit(users);
  }
}
