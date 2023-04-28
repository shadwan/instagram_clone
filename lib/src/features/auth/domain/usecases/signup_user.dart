import '../../../../shared/domain/usecases/usecases.dart';
import '../entities/logged_in_user.dart';
import '../repositories/auth_repository.dart';

class SignupUser implements UseCase<void, SignupUserParams> {
  final AuthRepository authRepository;

  SignupUser(this.authRepository);

  @override
  Future<void> call(SignupUserParams params) {
    //  TODO: add another repository to save the user into a database when user registers
    return authRepository.signup(
      loggedInUser: params.user,
    );
  }
}

class SignupUserParams extends Params {
  final LoggedInUser user;

  SignupUserParams({required this.user});

  @override
  List<Object?> get props => [user];
}
