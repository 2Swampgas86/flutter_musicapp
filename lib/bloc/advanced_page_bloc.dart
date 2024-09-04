
import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';

part 'advanced_page_event.dart';
part 'advanced_page_state.dart';

class AdvancedPageBloc extends Bloc<AdvancedPageEvent, AdvancedPageState> {
  AdvancedPageBloc() : super(AdvancedOpeningState()) {
    on<NavigateToNextPage>((event, emit) {
      emit(AdvancedOptionState());
    });
  }
}