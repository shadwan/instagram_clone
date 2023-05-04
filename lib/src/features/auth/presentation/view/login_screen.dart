import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/presentation/widgets/widgets.dart';
import '../blocs/login/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {},
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Spacer(flex: 3),
                _Username(),
                const SizedBox(height: 10),
                _Password(),
                const SizedBox(height: 10),
                _LoginButton(),
                Spacer(flex: 2),
                _SignupRedirect(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SignupRedirect extends StatelessWidget {
  const _SignupRedirect({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.goNamed('signup');
      },
      child: RichText(
        text: TextSpan(
          children: [
            const TextSpan(text: 'Don\'t you have an account? '),
            TextSpan(
              text: 'Signup',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) {
        return previous.status != current.status;
      },
      builder: (context, state) {
        return state.status == FormzStatus.submissionInProgress
            ? const CircularProgressIndicator(color: Colors.white)
            : ElevatedButton(
                onPressed: () {
                  state.status == FormzStatus.valid
                      ? context.read<LoginCubit>().logInWithCredentials()
                      : ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Check your username and password: ${state.status}',
                            ),
                          ),
                        );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  minimumSize: const Size(100, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Text(
                  'Login',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.black),
                ),
              );
      },
    );
  }
}

class _Password extends StatelessWidget {
  const _Password({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) {
        return previous.password != current.password;
      },
      builder: (context, state) {
        return CustomTextField(
          labelText: 'Password',
          obsecureText: true,
          errorText: state.password.invalid ? 'The password is invalid' : null,
          onChanged: (password) {
            context.read<LoginCubit>().passwordChanged(password);
          },
        );
      },
    );
  }
}

class _Username extends StatelessWidget {
  const _Username({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) {
        return previous.username != current.username;
      },
      builder: (context, state) {
        return CustomTextField(
          labelText: 'Username',
          errorText: state.username.invalid ? 'The username is invalid' : null,
          onChanged: (username) {
            context.read<LoginCubit>().usernameChanged(username);
          },
          textInputType: TextInputType.name,
        );
      },
    );
  }
}
