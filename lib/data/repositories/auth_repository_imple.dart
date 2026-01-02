import 'package:blog_app/core/error/exception.dart';
import 'package:blog_app/data/data_sources/auth_supabase_data_source.dart';
import 'package:blog_app/domain/repositories/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../../core/error/failures.dart';

class AuthRepositoryImple implements AuthRepository{
  final AuthSupabaseDataSource supabaseDataSource;
  const AuthRepositoryImple(this.supabaseDataSource);

  @override
  Future<Either<Failure, String>> signUpWithEmailPassword({required String name, required String email, required String password}) async{
    try{
      final userId = await supabaseDataSource.signUpWithEmailPassword(
          name: name,
          email: email,
          password: password
      );
      return right(userId);
    } on ServerException catch(e){
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> signInWithEmailPassword({required String email, required String password}) {
    throw UnimplementedError();
  }

}