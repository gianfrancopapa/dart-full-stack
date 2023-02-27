import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_web_socket/dart_frog_web_socket.dart';
import 'package:users_api/src/users/bloc/users_bloc.dart';

Future<Response> onRequest(RequestContext context) async {
  final handler = webSocketHandler(
    (channel, protocol) {
      // A new client has connected to our server.
      // Subscribe the new client to receive notifications
      // whenever the cubit state changes.
      final bloc = context.read<UsersBloc>()..subscribe(channel);

      // Send the current users to the new client.
      channel.sink.add(bloc.state.toString());

      // Listen for messages from the client.
      channel.stream.listen(
        (event) {
          switch (event) {
            // Handle an increment message.
            case '__addUser__':
              bloc.add(const UserCreated(name: 'Test'));
              break;
            // Handle a decrement message.
            case '__removeUser__':
              bloc.add(const UserDeleted(id: 1));
              break;
            // Ignore any other messages.
            default:
              break;
          }
        },
        // The client has disconnected.
        // Unsubscribe the channel.
        onDone: () => bloc.unsubscribe(channel),
      );
    },
  );

  return handler(context);
}
