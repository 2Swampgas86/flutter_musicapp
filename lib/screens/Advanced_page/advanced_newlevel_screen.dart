import 'package:musicapp/bloc/advanced_page_bloc.dart';
import 'package:musicapp/screens/Advanced_page/Advanced_level_options.dart';
import 'package:musicapp/screens/Advanced_page/advanced_page_opening.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AdvancedPage extends StatelessWidget {
  const AdvancedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdvancedPageBloc(),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<AdvancedPageBloc, AdvancedPageState>(
            builder: (context, state) {
              return GestureDetector(
                onTap: () {
                  context.read<AdvancedPageBloc>().add(NavigateToNextPage());
                },
                child: _buildPage(state),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPage(AdvancedPageState state) {
    if (state is AdvancedOptionState) {
      return const AdvancedOption();
    }
    return const AdvancedOpening();
  }
}
