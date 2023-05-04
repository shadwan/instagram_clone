import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../../shared/domain/entities/user.dart';
import '../../../domain/entities/logged_in_user.dart';
import '../../../domain/usecases/login_user.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUser _loginUser;

  LoginCubit({
    required LoginUser loginUser,
  })  : _loginUser = loginUser,
        super(LoginState.initial());

  void usernameChanged(String value) {
    final username = Username.dirty(value);
    emit(
      state.copyWith(
        username: username,
        status: Formz.validate(
          [username, state.password],
        ),
      ),
    );
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(
      state.copyWith(
        password: password,
        status: Formz.validate(
          [state.username, password],
        ),
      ),
    );
  }

  Future<void> logInWithCredentials() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _loginUser(
        LoginUserParams(
          username: state.username,
          password: state.password,
        ),
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch (err) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
