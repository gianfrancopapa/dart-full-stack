import 'package:app/bootstrap.dart';
import 'package:app/users/view/users_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users_repository/users_repository.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main() {
  bootstrap(() async {
    const baseUrl = String.fromEnvironment('API_URL');

    final uri = Uri.parse('$baseUrl/api/v1/users/ws');
    final channel = WebSocketChannel.connect(uri);

    final usersRepository = UsersRepository(
      webSocketChannel: channel,
    );

    return App(
      usersRepository: usersRepository,
    );
  });
}

class App extends StatelessWidget {
  const App({
    super.key,
    required usersRepository,
  }) : _usersRepository = usersRepository;

  final UsersRepository _usersRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _usersRepository),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Users Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const UsersRoute(),
    );
  }
}
