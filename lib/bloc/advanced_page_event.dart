part of 'advanced_page_bloc.dart';

abstract class AdvancedPageEvent extends Equatable {
  const AdvancedPageEvent();

  @override
  List<Object> get props => [];
}

class NavigateToNextPage extends AdvancedPageEvent {}
