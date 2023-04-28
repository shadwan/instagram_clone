import 'package:instagram_clone/src/features/auth/domain/entities/logged_in_user.dart';
import 'package:instagram_clone/src/features/auth/data/datasources/mock_auth_datasource.dart';
import 'package:instagram_clone/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:instagram_clone/src/shared/domain/entities/user.dart';

class AuthRepositoryImpl extends AuthRepository {
  final MockAuthDatasource authDatasource;

  AuthRepositoryImpl(this.authDatasource);

  @override
  Future<LoggedInUser> get loggedInUser => authDatasource.loggedInUser;

  @override
  Future<void> login({
    required Username username,
    required Password password,
  }) {
    return authDatasource.login(username: username, password: password);
  }

  @override
  Future<void> logout() {
    return authDatasource.logout();
  }

  @override
  Future<void> signup({required LoggedInUser loggedInUser}) {
    return authDatasource.signup(loggedInUser: loggedInUser);
  }

  @override
  Stream<AuthStatus> get status => authDatasource.status;
}
