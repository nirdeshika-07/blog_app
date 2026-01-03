import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/domain/entities/user.dart';
import 'package:fpdart/fpdart.dart';

//To define a set of methods that a class must implement
abstract interface class AuthRepository{
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<Failure, User>> signInWithEmailPassword({
    required String email,
    required String password,
  });
}

