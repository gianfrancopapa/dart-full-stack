import 'package:dart_frog/dart_frog.dart';
import 'package:postgres/postgres.dart';
import 'package:users_api/src/data/postgres_data_source.dart';
import 'package:users_api/src/data/users_data_source.dart';

final _connection = PostgreSQLConnection(
  'localhost',
  5432,
  'postgres',
  username: 'postgres',
  password: 'changeme',
);

final _usersDataSource = PostgresUsersDataSource(connection: _connection);

Handler middleware(Handler handler) {
  return handler
      .use(requestLogger())
      .use(provider<UsersDataSource>((_) => _usersDataSource));
}
