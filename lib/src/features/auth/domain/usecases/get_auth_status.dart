import 'package:instagram_clone/src/features/auth/data/datasources/mock_auth_datasource.dart';
import 'package:instagram_clone/src/shared/domain/usecases/usecases.dart';

import '../repositories/auth_repository.dart';

class GetAuthStatus implements UseCase<void, NoParams> {
  final AuthRepository authRepository;

  GetAuthStatus(this.authRepository);

  @override
  Stream<AuthStatus> call(NoParams params) {
    return authRepository.status;
  }
}
