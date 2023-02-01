import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_web_socket/dart_frog_web_socket.dart';
import 'package:users_api/api.dart';

final users = [
  const User(id: '1', name: 'Gianfranco', email: 'gianfranco@email.com'),
  const User(id: '2', name: 'Gianfranco2', email: 'gianfranco@email.com'),
  const User(id: '3', name: 'Gianfranco3', email: 'gianfranco@email.com'),
];

final clients = <WebSocketChannel>[];

Future<Response> onRequest(RequestContext context) async {
  final handler = webSocketHandler(
    (channel, protocol) {
      // Add client to our client list
      clients.add(channel);

      // Send a message to the client.
      channel.sink.add(jsonEncode(users));

      // Listen for messages from the client.
      channel.stream.listen(
        (message) {
          final nextId = (users.length + 1).toString();
          users.add(
            User(
              id: nextId,
              name: 'Gianfranco$nextId',
              email: 'gianfranco@email.com',
            ),
          );
          for (final client in clients) {
            client.sink.add(jsonEncode(users));
          }
        },
        // The client has disconnected.
        onDone: () => clients.remove(channel),
      );
    },
  );

  return handler(context);
}
