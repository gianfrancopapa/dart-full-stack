import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users_api/api.dart';
import 'package:users_repository/users_repository.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc({required UsersRepository usersRepository})
      : _usersRepository = usersRepository,
        super(const UsersState.initial()) {
    on<UsersFetched>(_onUsersFetched);

    final uri = Uri.parse('ws://localhost:8080/api/v1/users/ws');
    final channel = WebSocketChannel.connect(uri);

    _streamSubscription = channel.stream.listen(
      (message) {
        final encodedUsers = jsonDecode(message) as List<dynamic>;
        final users = encodedUsers.map((user) => User.fromJson(user)).toList();
        add(UsersFetched(users: users));
      },
    );
  }

  final UsersRepository _usersRepository;
  late final StreamSubscription _streamSubscription;

  Future<void> _onUsersFetched(
    UsersFetched event,
    Emitter<UsersState> emit,
  ) async {
    try {
      emit(state.copyWith(status: UsersStatus.loading));
      await Future.delayed(const Duration(seconds: 1));

      emit(
        state.copyWith(
          status: UsersStatus.loaded,
          users: event.users,
        ),
      );
    } on UsersRepositoryException {
      emit(state.copyWith(status: UsersStatus.error));
    }
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }
}
