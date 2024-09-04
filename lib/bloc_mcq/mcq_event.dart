

import 'package:equatable/equatable.dart';

sealed class McqEvent extends Equatable {
  const McqEvent();

  @override
  List<Object> get props => [];
}
class OptionSelected extends McqEvent {
  final String selectedOption;

  const OptionSelected(this.selectedOption);

  @override
  List<Object> get props => [selectedOption];
}

class NextQuestion extends McqEvent {}