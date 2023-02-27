import 'package:postgres/postgres.dart';
import 'package:users_api/src/data/models/user.dart';
import 'package:users_api/src/data/users_data_source.dart';

/// {@template get_users_by_id_failure}
/// Thrown during the get users by id if a failure occurs.
/// {@endtemplate}
class GetUserByIdFailure implements Exception {
  /// {@macro get_users_by_id_failure}
  const GetUserByIdFailure();
}

/// {@template postgres_users_data_source}
/// An database implementation of the [UsersDataSource] interface.
/// {@endtemplate}
class PostgresUsersDataSource extends UsersDataSource {
  PostgresUsersDataSource({
    required PostgreSQLConnection connection,
  }) : _connection = connection;

  final PostgreSQLConnection _connection;

  @override
  Future<List<User>> getAllUsers() async {
    if (_connection.isClosed) {
      await _connection.open();
    }

    final usersFromPostgres = await _connection.query('SELECT * FROM users');

    final users = usersFromPostgres
        .map((u) => u.toColumnMap())
        .map(User.fromJson)
        .toList();

    return users;
  }

  @override
  Future<User> getUserById({required String id}) async {
    if (_connection.isClosed) {
      await _connection.open();
    }

    final result = await _connection.query(
      'SELECT * FROM users WHERE id = @id',
      substitutionValues: {'id': id},
    );

    if (result.isEmpty) {
      throw const GetUserByIdFailure();
    }

    final user = User.fromJson(result.first.toColumnMap());

    return user;
  }
}
