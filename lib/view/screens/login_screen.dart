import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:note_taking_app/constants/routes.dart';
import 'package:note_taking_app/view/widgets/gap.dart';
import 'package:note_taking_app/view/widgets/screen_wrapper.dart';
import 'package:note_taking_app/view/widgets/text_divider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void navigateToSignup() {
    context.go('/${ROUTES_NAME.signup}');
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWrapper(
      showAppBar: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Email text field
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              hintText: 'Enter your email',
            ),
            keyboardType: TextInputType.emailAddress,
          ),

          // Password text field
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(
              labelText: 'Password',
              hintText: 'Enter your password',
            ),
            obscureText: true,
          ),

          const Gap(y: 16),

          ElevatedButton(
            onPressed: () {
              // Access email and password using controllers
              String email = _emailController.text;
              String password = _passwordController.text;

              // TODO: Implement login logic with email and password
            },
            child: const Text('Login'),
          ),

          const TextDivider(text: "OR"),

          ElevatedButton(
            onPressed: () {
              // TODO: Implement Google login logic
            },
            child: const Text('Login with Google'),
          ),

          const Gap(y: 16),

          // "Don't have an account? Sign up here" section
          TextButton(
            onPressed: navigateToSignup,
            child: const Text("Don't have an account? Sign up here"),
          ),
        ],
      ),
    );
  }
}
