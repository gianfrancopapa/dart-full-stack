import 'package:dart_frog/dart_frog.dart';
import 'package:users_api/src/users/middleware/users_provider.dart';

Handler middleware(Handler handler) => handler.use(userProvider);
