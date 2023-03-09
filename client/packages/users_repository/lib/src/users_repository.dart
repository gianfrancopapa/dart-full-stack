import 'dart:async';
import 'dart:convert';
import 'package:users_api/api.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

abstract class UsersRepositoryException implements Exception {
  /// {@macro users_repository_exception}
  const UsersRepositoryException(this.error, this.stackTrace);

  /// The underlying error that occurred.
  final Object error;

  /// The relevant stack trace.
  final StackTrace stackTrace;
}

/// {@template get_users}
/// Thrown during the get users if a failure occurs.
/// {@endtemplate}
class GetUsersFailure extends UsersRepositoryException {
  /// {@macro get_users}
  const GetUsersFailure(Object error, StackTrace stackTrace)
      : super(error, stackTrace);
}

class UsersRepository {
  UsersRepository({
    required WebSocketChannel webSocketChannel,
  }) : _webSocketChannel = webSocketChannel;

  final WebSocketChannel _webSocketChannel;

  Stream<List<User>> users() async* {
    await for (var message in _webSocketChannel.stream) {
      final encodedUsers = jsonDecode(message) as List<dynamic>;
      final users = encodedUsers.map((user) => User.fromJson(user)).toList();

      yield* Stream.value(users);
    }
  }
}
