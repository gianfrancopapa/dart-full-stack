import 'package:dart_frog/dart_frog.dart';
import 'package:users_api/src/users/bloc/users_bloc.dart';

final _users = UsersBloc();

/// Provide the users instance via `RequestContext`.
final userProvider = provider<UsersBloc>((_) => _users);
