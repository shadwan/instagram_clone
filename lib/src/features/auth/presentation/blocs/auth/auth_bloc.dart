import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram_clone/src/features/auth/data/datasources/mock_auth_datasource.dart';
import 'package:instagram_clone/src/features/auth/domain/entities/logged_in_user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
