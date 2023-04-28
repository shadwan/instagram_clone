import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/presentation/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: const [
            Spacer(
              flex: 3,
            ),
            _Username(),
            SizedBox(
              height: 10,
            ),
            _Password(),
            SizedBox(
              height: 10,
            ),
            _LoginButton(),
            Spacer(
              flex: 2,
            ),
            _SignupRedirect(),
          ],
        ),
      )),
    );
  }
}

class _SignupRedirect extends StatelessWidget {
  const _SignupRedirect({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.goNamed('signup');
      },
      child: RichText(
        text: TextSpan(
          children: [
            const TextSpan(
              text: "Don't have an account? ",
            ),
            TextSpan(
              text: 'Signup',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            )
          ],
        ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        minimumSize: const Size(100, 50),
      ),
      child: Text(
        'Login',
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: Colors.black),
      ),
    );
  }
}

class _Password extends StatelessWidget {
  const _Password({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CustomTextField(
      labelText: "Password",
      textInputType: TextInputType.name,
      obsecureText: true,
    );
  }
}

class _Username extends StatelessWidget {
  const _Username({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CustomTextField(
      labelText: "Username",
      textInputType: TextInputType.name,
    );
  }
}
