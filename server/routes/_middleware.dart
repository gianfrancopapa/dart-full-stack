import 'package:dart_frog/dart_frog.dart';
import 'package:users_api/src/data/in_memory_users_data_source.dart';
import 'package:users_api/src/data/users_data_source.dart';

final _usersDataSource = InMemoryUsersDataSource();

Handler middleware(Handler handler) {
  return handler
      .use(requestLogger())
      .use(provider<UsersDataSource>((_) => _usersDataSource));
}
