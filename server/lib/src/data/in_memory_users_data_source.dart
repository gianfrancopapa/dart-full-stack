import 'package:users_api/src/data/models/user.dart';
import 'package:users_api/src/data/users_data_source.dart';

/// {@template in_memory_users_data_source}
/// An in-memory implementation of the [UsersDataSource] interface.
/// {@endtemplate}
class InMemoryUsersDataSource extends UsersDataSource {
  /// In memory [User] list
  final List<User> users = const [
    User(id: 1, name: 'Gianfranco', email: 'gianfranco@email.com'),
    User(id: 2, name: 'Gianfranco2', email: 'gianfranco@email.com'),
    User(id: 3, name: 'Gianfranco3', email: 'gianfranco@email.com'),
    User(id: 4, name: 'Gianfranco4', email: 'gianfranco@email.com'),
    User(id: 5, name: 'Gianfranco5', email: 'gianfranco@email.com'),
  ];

  @override
  Future<List<User>> getAllUsers() async {
    return users;
  }

  @override
  Future<User> getUserById({required String id}) async {
    return users.firstWhere(
      (user) => user.id == id,
      orElse: () => const User.empty(),
    );
  }
}
