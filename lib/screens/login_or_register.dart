
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicapp/screens/sign_in.dart';
import 'package:musicapp/screens/sign_up.dart';

import 'package:musicapp/bloc/auth_bloc.dart';
import 'package:musicapp/bloc/auth_event.dart';
import 'package:musicapp/bloc/auth_state.dart';

class LogInOrRegisterPage extends StatelessWidget {
  const LogInOrRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthPageState) {
          if (state.showLoginPage) {
            return SignIn(onTap: () => context.read<AuthBloc>().add(ToggleAuthPage()));
          } else {
            return SignUp(onTap: () => context.read<AuthBloc>().add(ToggleAuthPage()));
          }
        } else {
          return SignIn(onTap: () => context.read<AuthBloc>().add(ToggleAuthPage()));
        }
      },
    );
  }
}
