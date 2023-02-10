part of 'number_trivia_bloc.dart';

abstract class NumberTriviaState extends Equatable {
  final List _props;
  const NumberTriviaState([this._props = const <dynamic>[]]);

  @override
  List<Object> get props => [_props];
}

class Empty extends NumberTriviaState {}

class Loading extends NumberTriviaState {}

class Loaded extends NumberTriviaState {
  final NumberTrivia trivia;

  const Loaded({
    required this.trivia,
  });

  @override
  List<Object> get props => [trivia];
}

class Error extends NumberTriviaState {
  final String message;

  const Error({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
