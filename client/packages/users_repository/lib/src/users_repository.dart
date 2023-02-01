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
    required ApiClient apiClient,
  }) : _apiClient = apiClient;

  final ApiClient _apiClient;

  Stream getUsers() async* {
    final uri = Uri.parse('ws://localhost:8080/api/v1/users/ws');
    final channel = WebSocketChannel.connect(uri);

    yield channel.stream;
  }
}
