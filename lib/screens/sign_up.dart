
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:musicapp/bloc/auth_bloc.dart';
import 'package:musicapp/bloc/auth_event.dart';
import 'package:musicapp/bloc/auth_state.dart';
import 'package:musicapp/models/my_button.dart';
import 'package:musicapp/models/my_textfield.dart';
import 'package:musicapp/models/square_tile.dart';
import 'package:musicapp/screens/choosing_levels_screen.dart';
import 'package:musicapp/services/auth_services.dart';


class SignUp extends StatelessWidget {
  final Function() onTap;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpasswordController =
      TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  SignUp({required this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // your existing UI code
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSignInSuccess && state.isSignUp) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const ChooseClass()));}
          else
          if (state is AuthError) {
            // Show error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  const Icon(Icons.lock, size: 100),
                  const SizedBox(height: 50),
                  MyTextField(
                    controller: nameController,
                    hintText: 'Name',
                    obscureText: false,
                  ),
                  MyTextField(
                    controller: ageController,
                    hintText: 'Age',
                    obscureText: false,
                  ),
                  const SizedBox(height: 10),
                  const SizedBox(height: 10),
                  MyTextField(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false,
                  ),
                  const SizedBox(height: 10),
                  MyTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                  ),
                  const SizedBox(height: 10),
                  MyTextField(
                    controller: confirmpasswordController,
                    hintText: 'Confirm Password',
                    obscureText: true,
                  ),
                  const SizedBox(height: 10),
                  MyButton(
                    onTap: () {
                      if (passwordController.text ==
                          confirmpasswordController.text) {
                        context.read<AuthBloc>().add(
                              SignUpRequested(
                                  emailController.text.trim(),
                                  passwordController.text.trim(),
                                  nameController.text.trim(),
                                  ageController.text.trim()),
                            );
                      } else {
                        // Show password mismatch error
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Passwords do not match')),
                        );
                      }
                    },
                    text: "Sign Up",
                  ),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        Expanded(
                            child: Divider(
                                thickness: 0.5, color: Colors.grey[400])),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text('Or continue with',
                              style: TextStyle(color: Colors.grey[700])),
                        ),
                        Expanded(
                            child: Divider(
                                thickness: 0.5, color: Colors.grey[400])),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SquareTile(onTap: () =>AuthService().signInWithGoogle() ,
                        imagePath: 'assets/images/google.png'),
                      const SizedBox(width: 25),
                      SquareTile(onTap: (){},imagePath: 'assets/images/apple.png'),
                    ],
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account?',
                          style: TextStyle(color: Colors.grey[700])),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: onTap,
                        child: const Text(
                          'Login now',
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
