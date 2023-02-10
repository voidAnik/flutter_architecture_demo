// ignore_for_file: constant_identifier_names

import 'package:clean_architecture_tdd/core/error/failures.dart';
import 'package:clean_architecture_tdd/core/use_cases/use_case.dart';
import 'package:clean_architecture_tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/util/input_converter.dart';
import '../../domain/use_cases/get_concrete_number_trivia.dart';
import '../../domain/use_cases/get_random_number_trivia.dart';

part 'number_trivia_event.dart';

part 'number_trivia_state.dart';

const String SERVER_FAILURE_MESSAGE = "Server Failure";
const String CACHE_FAILURE_MESSAGE = "Cache Failure";
const String INVALID_INPUT_FAILURE_MESSAGE =
    "Invalid Input - The number must be a positive number";

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  NumberTriviaBloc(
      {required this.getConcreteNumberTrivia,
      required this.getRandomNumberTrivia,
      required this.inputConverter})
      : super(Empty()) {
    on<GetTriviaForConcreteNumber>((event, emit) async {
       await _onEventGetTriviaForConcreteNumber(event, emit);
    });

    on<GetTriviaForRandomNumber>((event, emit) async {
       await _onEventGetTriviaForRandomNumber(emit);
    });
  }

  Future<void> _onEventGetTriviaForConcreteNumber(
      GetTriviaForConcreteNumber event, Emitter<NumberTriviaState> emit) async{
    final inputEither = inputConverter.stringToUnsignedInt(event.numberString);
    await inputEither.fold((failure) {
      emit(const Error(message: INVALID_INPUT_FAILURE_MESSAGE));
    }, (integer) async {
      emit(Loading());
      final failureOrTrivia =
          await getConcreteNumberTrivia(Params(number: integer));
      _eitherLoadedOrErrorState(emit, failureOrTrivia);
    });
  }

  void _eitherLoadedOrErrorState(Emitter<NumberTriviaState> emit,
      Either<Failure, NumberTrivia> failureOrTrivia) async {
    emit(failureOrTrivia.fold(
      (failure) => Error(message: failure.getMessage()),
      (trivia) => Loaded(trivia: trivia),
    ));
  }

  Future<void> _onEventGetTriviaForRandomNumber(
      Emitter<NumberTriviaState> emit) async {
    emit(Loading());
    final failureOrTrivia = await getRandomNumberTrivia(NoParams());
    _eitherLoadedOrErrorState(emit, failureOrTrivia);
  }
}

extension on Failure {
  String getMessage() {
    switch (runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return "Unexpected error";
    }
  }
}
