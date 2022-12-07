import 'package:users_api/src/data/models/models.dart';

/// {@template users_data_source}
/// Interface that defines all the methods for Users data source
/// {@endtemplate}
abstract class UsersDataSource {
  /// Returns the list of all the [User]
  Future<List<User>> getAllUsers();

  /// Returns a [User] based on the provided [id]
  /// 
  /// Returns an empty [User] if the id doesn't exist
  Future<User> getUserById({required String id});
}
