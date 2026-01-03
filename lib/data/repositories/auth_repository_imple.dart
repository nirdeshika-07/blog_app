import 'package:blog_app/core/error/exception.dart';
import 'package:blog_app/data/data_sources/auth_supabase_data_source.dart';
import 'package:blog_app/domain/entities/user.dart';
import 'package:blog_app/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../core/error/failures.dart';

class AuthRepositoryImple implements AuthRepository{
  final AuthSupabaseDataSource supabaseDataSource;
  const AuthRepositoryImple(this.supabaseDataSource);

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword({required String name, required String email, required String password}) async{
     return _getUser(() async => await supabaseDataSource.signUpWithEmailPassword(
          name: name,
          email: email,
          password: password
        ),
      );
  }

  @override
  Future<Either<Failure, User>> signInWithEmailPassword({required String email, required String password}) async{
      return _getUser(() async=>
          await supabaseDataSource.signInWithEmailPassword(
          email: email,
          password: password
      ),
    );
  }
  Future<Either<Failure, User>> _getUser(
      Future<User> Function() fn
      ) async {
    try {
      final user = await fn();
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}