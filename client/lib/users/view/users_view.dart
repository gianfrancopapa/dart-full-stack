import 'package:flutter/material.dart';
import 'package:app/users/users.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersView extends StatelessWidget {
  const UsersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: BlocBuilder<UsersBloc, UsersState>(
        buildWhen: ((previous, current) => previous.status != current.status),
        builder: (context, state) {
          if (state.status == UsersStatus.loading) {
            return const Center(
              child: SizedBox(
                height: 50.0,
                width: 50.0,
                child: CircularProgressIndicator(),
              ),
            );
          }
          return const _UsersList();
        },
      ),
    );
  }
}

class _UsersList extends StatelessWidget {
  const _UsersList();

  @override
  Widget build(BuildContext context) {
    final users = context.select((UsersBloc bloc) => bloc.state.users);

    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];

        return ListTile(
          leading: const Icon(Icons.person),
          title: Text(user.name),
          subtitle: Text(user.email),
        );
      },
    );
  }
}
