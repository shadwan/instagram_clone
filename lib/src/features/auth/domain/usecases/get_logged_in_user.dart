import 'package:instagram_clone/src/shared/domain/usecases/usecases.dart';

import '../repositories/auth_repository.dart';

class GetLoggedInUser implements UseCase<void, NoParams> {
  final AuthRepository authRepository;

  GetLoggedInUser(this.authRepository);

  @override
  Future<void> call(NoParams params) {
    return authRepository.loggedInUser;
  }
}
