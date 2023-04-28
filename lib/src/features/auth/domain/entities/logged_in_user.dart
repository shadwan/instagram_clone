import 'package:formz/formz.dart';
import 'package:instagram_clone/src/shared/domain/entities/user.dart';

class LoggedInUser extends User {
  final Email? email;

  const LoggedInUser({
    required super.id,
    required super.username,
    super.followers,
    super.followings,
    super.imagePath,
    this.email,
  });

  @override
  List<Object?> get props =>
      [id, username, followers, followings, imagePath, email];

  static const empty =
      LoggedInUser(id: '-', username: Username.pure(), email: Email.pure());

  LoggedInUser copyWith({
    String? id,
    Username? username,
    int? followers,
    int? followings,
    String? imagePath,
    Email? email,
  }) {
    return LoggedInUser(
      id: id ?? this.id,
      username: username ?? this.username,
      followers: followers ?? this.followers,
      followings: followings ?? this.followings,
      imagePath: imagePath ?? this.imagePath,
      email: email ?? this.email,
    );
  }
}

enum EmailValidationError { invalid }

class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure() : super.pure('');

  const Email.dirty([String value = '']) : super.dirty(value);

  static final RegExp _emailRegExp = RegExp(
    // Regex to validate email
    r'^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z0-9]+$',
  );

  @override
  EmailValidationError? validator(String value) {
    return _emailRegExp.hasMatch(value) ? null : EmailValidationError.invalid;
  }
}

enum PasswordValidationError { invalid }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');

  const Password.dirty([String value = '']) : super.dirty(value);

  static final RegExp _passwordRegExp = RegExp(
    //Regex to validate password at least 8 charecters long and made of letters and numbers
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  @override
  PasswordValidationError? validator(String value) {
    return _passwordRegExp.hasMatch(value)
        ? null
        : PasswordValidationError.invalid;
  }
}
