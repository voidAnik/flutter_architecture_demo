import 'package:bloc_test/bloc_test.dart';
import 'package:clean_architecture_tdd/core/error/failures.dart';
import 'package:clean_architecture_tdd/core/use_cases/use_case.dart';
import 'package:clean_architecture_tdd/core/util/input_converter.dart';
import 'package:clean_architecture_tdd/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_architecture_tdd/features/number_trivia/domain/use_cases/get_concrete_number_trivia.dart';
import 'package:clean_architecture_tdd/features/number_trivia/domain/use_cases/get_random_number_trivia.dart';
import 'package:clean_architecture_tdd/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'number_trivia_bloc_test.mocks.dart';

@GenerateMocks([GetConcreteNumberTrivia, GetRandomNumberTrivia, InputConverter])
void main() {
  late NumberTriviaBloc bloc;
  late MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  late MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  late MockInputConverter mockInputConverter;

  setUp(() {
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();
    bloc = NumberTriviaBloc(
      getConcreteNumberTrivia: mockGetConcreteNumberTrivia,
      getRandomNumberTrivia: mockGetRandomNumberTrivia,
      inputConverter: mockInputConverter,
    );
  });

  test("initial state should ber empty", () async {
    // assert
    expect(bloc.state, Empty());
  });

  group("GetTriviaForConcreteNumber", () {
    const tNumberString = "1";
    const tNumberParsed = 1;
    const tNumberTrivia = NumberTrivia(text: "test_trivia", number: 1);

    void setUpMockInputConvertedSuccess(){
      when(mockInputConverter.stringToUnsignedInt(any))
          .thenReturn(const Right(tNumberParsed));
    }

    blocTest("should call the InputConverter to validate and convert the string to an unsigned integer",
        build: () {
          setUpMockInputConvertedSuccess();
          when(mockGetConcreteNumberTrivia(any)).thenAnswer((_) async => const Right(tNumberTrivia));
          return bloc;
        },
      act: (bloc) => bloc.add(const GetTriviaForConcreteNumber(numberString: tNumberString)),
      verify: (_) => mockInputConverter.stringToUnsignedInt(tNumberString)
    );

    blocTest("should emit [Error] when the input is invalid",
        build: (){
          when(mockInputConverter.stringToUnsignedInt(any))
              .thenReturn(Left(InvalidInputFailure()));
          return bloc;
        },
      act: (bloc) => bloc.add(const GetTriviaForConcreteNumber(numberString: tNumberString)),
      expect: () => [const Error(message: INVALID_INPUT_FAILURE_MESSAGE)]
    );

    blocTest("should get data from the concrete use case",
        build: () {
          setUpMockInputConvertedSuccess();
          when(mockGetConcreteNumberTrivia(any)).thenAnswer((_) async => const Right(tNumberTrivia));
          return bloc;
    },
      act: (bloc) => bloc.add(const GetTriviaForConcreteNumber(numberString: tNumberString)),
      verify: (_) => mockGetConcreteNumberTrivia(const Params(number: tNumberParsed)
    )
    );

    blocTest("should emit [loading, loaded] when data gotten successfully",
      build: () {
        setUpMockInputConvertedSuccess();
        when(mockGetConcreteNumberTrivia(any)).thenAnswer((_) async => const Right(tNumberTrivia));
        return bloc;
      },
      act: (bloc) => bloc.add(const GetTriviaForConcreteNumber(numberString: "abd")),
      expect: () => [
        Loading(),
        const Loaded(trivia: tNumberTrivia),
      ],
    );

    blocTest("should emit [loading, Error] when data failed",
        build: () {
      setUpMockInputConvertedSuccess();
      when(mockGetConcreteNumberTrivia(any)).thenAnswer((_) async => Left(ServerFailure()));
      return bloc;
        },
      act: (bloc) => bloc.add(const GetTriviaForConcreteNumber(numberString: tNumberString)),
      expect: () => [
        Loading(),
        const Error(message: SERVER_FAILURE_MESSAGE),
      ],
    );

    blocTest("should emit [Loading, Error] with a proper message for the error when getting data fails",
      build: () {
        setUpMockInputConvertedSuccess();
        when(mockGetConcreteNumberTrivia(any)).thenAnswer((_) async => Left(CacheFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(const GetTriviaForConcreteNumber(numberString: tNumberString)),
      expect: () => [
        Loading(),
        const Error(message: CACHE_FAILURE_MESSAGE),
      ],
    );

  });

  group("GetTriviaForRandomNumber", () {
    const tNumberTrivia = NumberTrivia(text: "test_trivia", number: 1);

    blocTest("should get data from the random use case",
        build: () {
          when(mockGetRandomNumberTrivia(any)).thenAnswer((_) async => const Right(tNumberTrivia));
          return bloc;
        },
        act: (bloc) => bloc.add(GetTriviaForRandomNumber()),
        verify: (_) => mockGetRandomNumberTrivia(NoParams()
        )
    );

    blocTest("should emit [loading, loaded] when data gotten successfully",
      build: () {
        when(mockGetRandomNumberTrivia(any)).thenAnswer((_) async => const Right(tNumberTrivia));
        return bloc;
      },
      act: (bloc) => bloc.add( GetTriviaForRandomNumber()),
      expect: () => [
        Loading(),
        const Loaded(trivia: tNumberTrivia),
      ],
    );

    blocTest("should emit [loading, Error] when data failed",
      build: () {
        when(mockGetRandomNumberTrivia(any)).thenAnswer((_) async => Left(ServerFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add( GetTriviaForRandomNumber()),
      expect: () => [
        Loading(),
        const Error(message: SERVER_FAILURE_MESSAGE),
      ],
    );

    blocTest("should emit [Loading, Error] with a proper message for the error when getting data fails",
      build: () {
        when(mockGetRandomNumberTrivia(any)).thenAnswer((_) async => Left(CacheFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(GetTriviaForRandomNumber()),
      expect: () => [
        Loading(),
        const Error(message: CACHE_FAILURE_MESSAGE),
      ],
    );

  });

}
