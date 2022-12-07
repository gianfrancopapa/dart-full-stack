import 'package:flutter/material.dart';
import 'package:app/users/users.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users_repository/users_repository.dart';

class UsersRoute extends StatelessWidget {
  const UsersRoute({Key? key}) : super(key: key);

  static Route<void> route(BuildContext context) {
    return MaterialPageRoute(
      builder: (ctx) {
        return BlocProvider(
          create: (_) => UsersBloc(
            usersRepository: context.read<UsersRepository>(),
          ),
          child: const UsersView(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UsersBloc(
        usersRepository: context.read<UsersRepository>(),
      )..add(UsersFetched()),
      child: const UsersView(),
    );
  }
}
