import 'package:blog_app/core/error/exception.dart';
import 'package:blog_app/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthSupabaseDataSource{
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password
  });
  Future<UserModel> signInWithEmailPassword({
    required String email,
    required String password
  });
}

class AuthSupabaseDataSourceImple implements AuthSupabaseDataSource{
  final SupabaseClient supabaseClient ;
  AuthSupabaseDataSourceImple(this.supabaseClient);

  @override
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password
  }) async{
    try{
      final response = await supabaseClient.auth.signUp(password: password, email: email,
          data: {
            'name': name
          });
      if(response.user == null){
        throw const ServerException('User is null');
      }
      return UserModel.fromJson(response.user!.toJson());
    }catch(e){
      throw ServerException('Unexpected SignUp error: ${e.toString()}');
    }
  }
  @override
  Future<UserModel> signInWithEmailPassword({
    required String email,
    required String password
  }) async {
    try{
      final response = await supabaseClient.auth.signInWithPassword(password: password, email: email);
      if(response.user == null){
        throw const ServerException('User is null');
      }
      return UserModel.fromJson(response.user!.toJson());
    }catch (e){
      throw ServerException('Unexpected SignIn error: ${e.toString()}');
    }
  }
}