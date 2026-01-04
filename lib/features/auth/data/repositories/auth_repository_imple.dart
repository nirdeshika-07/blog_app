import 'package:blog_app/core/error/exception.dart';
import '../../../../core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/reusable/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/auth_supabase_data_source.dart';


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
  @override
  Future<Either<Failure, User>> currentUser() async{
    try{
      final user = await supabaseDataSource.getCurrentUserData();
      if(user == null){
        return left(Failure('User is not logged in'));
      }
      return right(user);
    }on ServerException catch(e){
      return left(Failure(e.message));
    }
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