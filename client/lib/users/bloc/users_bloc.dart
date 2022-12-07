import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users_api/api.dart';
import 'package:users_repository/users_repository.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc({required UsersRepository usersRepository})
      : _usersRepository = usersRepository,
        super(const UsersState.initial()) {
    on<UsersFetched>(_onUsersFetched);
  }

  final UsersRepository _usersRepository;

  Future<void> _onUsersFetched(
      UsersFetched event, Emitter<UsersState> emit) async {
    try {
      emit(state.copyWith(status: UsersStatus.loading));

      final users = await _usersRepository.getUsers();
      await Future.delayed(const Duration(seconds: 2));

      emit(
        state.copyWith(
          status: UsersStatus.loaded,
          users: users,
        ),
      );
    } on UsersRepositoryException {
      emit(state.copyWith(status: UsersStatus.error));
    }
  }
}
