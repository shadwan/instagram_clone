import 'package:instagram_clone/src/shared/domain/usecases/usecases.dart';

import '../entities/logged_in_user.dart';
import '../repositories/auth_repository.dart';

class GetLoggedInUser implements UseCase<LoggedInUser, NoParams> {
  final AuthRepository authRepository;

  GetLoggedInUser(this.authRepository);

  @override
  Future<LoggedInUser> call(NoParams params) {
    return authRepository.loggedInUser;
  }
}
