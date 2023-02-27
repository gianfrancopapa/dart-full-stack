import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:users_api/src/data/users_data_source.dart';

Future<Response> onRequest(RequestContext context, String id) async {
  final method = context.request.method;

  if (method == HttpMethod.get) {
    return _onGetRequest(context, id);
  }
  return Response(statusCode: HttpStatus.methodNotAllowed);
}

Future<Response> _onGetRequest(RequestContext context, String id) async {
  final userDataSource = context.read<UsersDataSource>();
  try {
    final user = await userDataSource.getUserById(id: id);
    return Response.json(
      body: user,
    );
  } catch (error) {
    return Response(
      statusCode: HttpStatus.notFound,
      body: 'User with id $id not found',
    );
  }
}
