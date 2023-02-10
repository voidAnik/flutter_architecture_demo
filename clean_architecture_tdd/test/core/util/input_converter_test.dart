
import 'package:clean_architecture_tdd/core/util/input_converter.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  late InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });
  
  group("stringToUnsignedInt", () { 
    
    test("should return an integer when the string represents unsigned integer", () async{
      // arrange
      const str = '123';
      // act
      final actual = inputConverter.stringToUnsignedInt(str);
      // assert
      expect(actual, const Right(123));
    });

    test("should return a failure when the string is not an integer", () async{
      // arrange
      const str = 'abc';
      // act
      final actual = inputConverter.stringToUnsignedInt(str);
      // assert
      expect(actual, Left(InvalidInputFailure()));
    });

    test("should return a failure when the string is a negative integer", () async{
      // arrange
      const str = '-123';
      // act
      final actual = inputConverter.stringToUnsignedInt(str);
      // assert
      expect(actual, Left(InvalidInputFailure()));
    });
  });
}