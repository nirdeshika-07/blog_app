import 'package:blog_app/core/error/exception.dart';
import '../../../../core/constant/constant.dart';
import '../../../../core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/network/connection_checker.dart';
import '../../../../core/reusable/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/auth_supabase_data_source.dart';
import '../models/user_model.dart';


class AuthRepositoryImple implements AuthRepository{
  final AuthSupabaseDataSource supabaseDataSource;
  final ConnectionChecker connectionChecker;
  const AuthRepositoryImple(
      this.supabaseDataSource,
      this.connectionChecker,
      );

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
      if (!await (connectionChecker.isConnected)) {
        final session = supabaseDataSource.currentUserSession;

        if (session == null) {
          return left(Failure('User not logged in!'));
        }

        return right(
          UserModel(
            id: session.user.id,
            email: session.user.email ?? '',
            name: '',
          ),
        );
      }
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
      if (!await (connectionChecker.isConnected)) {
        return left(Failure(Constant.noConnectionErrorMessage));
      }
      final user = await fn();
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}