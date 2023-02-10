import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  // If the subclasses have some properties, they'll get passed to this constructor
  // so that Equatable can perform value comparison.
  const Failure({this.properties =  const <dynamic>[]});

  final List properties;

  @override
  List<Object> get props => [properties];
}

class ServerFailure extends Failure{}

class CacheFailure extends Failure{}

extension on Failure{

  String getMsg(){
    switch(runtimeType){
      case ServerFailure:
        return "1";
      case CacheFailure:
        return "2";
      default:
        return "Unexpected";
    }
  }
}