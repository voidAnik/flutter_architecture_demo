import 'dart:convert';

import 'package:clean_architecture_tdd/core/error/exceptions.dart';
import 'package:clean_architecture_tdd/features/number_trivia/data/data_sources/number_trivia_remote_data_source.dart';
import 'package:clean_architecture_tdd/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'number_trivia_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MockClient mockClient;
  late NumberTriviaRemoteDataSourceImpl dataSource;

  setUp(() {
    mockClient = MockClient();
    dataSource = NumberTriviaRemoteDataSourceImpl(client: mockClient);
  });

  void setupMockClient200(){
    when(mockClient.get(any, headers: anyNamed("headers")))
        .thenAnswer((_) async => http.Response(fixture('trivia.json'), 200));
  }
  void setupMockClient404(){
    when(mockClient.get(any, headers: anyNamed("headers")))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('getConcreteNumberTrivia', () {
    const tNumber = 1;
    final tNumberTriviaModel = NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

    test(
        "should preform a GET request on a URL with number being the endpoint and with application/json header", () async {
      // arrange
     setupMockClient200();
      // act
      dataSource.getConcreteNumberTrivia(tNumber);
      //assert
      verify(mockClient.get(Uri.parse("http://numbersapi.com/$tNumber"),
        headers: {'Content-Type': 'application/json'},),);
    });

    test(
        "should return NumberTrivia when the response code is 200 (success)", () async {
      // arrange
      setupMockClient200();
      // act
      final actual = await dataSource.getConcreteNumberTrivia(tNumber);
      //assert
      verify(mockClient.get(Uri.parse("http://numbersapi.com/$tNumber"),
        headers: {'Content-Type': 'application/json'},),);
      expect(actual, tNumberTriviaModel);
    });

    test(
        "should throw a ServerException when the response code is 404 or other", () async {
      // arrange
      setupMockClient404();
      // act
      final call =  dataSource.getConcreteNumberTrivia;
      //assert
      expect(() => call(tNumber), throwsA(const TypeMatcher<ServerException>()));
    });
  });

  group('getRandomNumberTrivia', () {
    final tNumberTriviaModel = NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

    test(
        "should preform a GET request on a URL with number being the endpoint and with application/json header", () async {
      // arrange
      setupMockClient200();
      // act
      dataSource.getRandomNumberTrivia();
      //assert
      verify(mockClient.get(Uri.parse("http://numbersapi.com/random"),
        headers: {'Content-Type': 'application/json'},),);
    });

    test(
        "should return NumberTrivia when the response code is 200 (success)", () async {
      // arrange
      setupMockClient200();
      // act
      final actual = await dataSource.getRandomNumberTrivia();
      //assert
      verify(mockClient.get(Uri.parse("http://numbersapi.com/random"),
        headers: {'Content-Type': 'application/json'},),);
      expect(actual, tNumberTriviaModel);
    });

    test(
        "should throw a ServerException when the response code is 404 or other", () async {
      // arrange
      setupMockClient404();
      // act
      final call =  dataSource.getRandomNumberTrivia;
      //assert
      expect(() => call(), throwsA(const TypeMatcher<ServerException>()));
    });
  });
}