import 'package:blog_app/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/reusable/entities/user.dart';


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
  Future<Either<Failure, User>> currentUser();
}

