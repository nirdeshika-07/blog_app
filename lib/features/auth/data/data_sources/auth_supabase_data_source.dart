import 'package:blog_app/core/error/exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/user_model.dart';

abstract interface class AuthSupabaseDataSource{
  Session? get currentUserSession;

  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password
  });
  Future<UserModel> signInWithEmailPassword({
    required String email,
    required String password
  });
  Future<UserModel?> getCurrentUserData();
}

class AuthSupabaseDataSourceImple implements AuthSupabaseDataSource{
  final SupabaseClient supabaseClient ;
  AuthSupabaseDataSourceImple(this.supabaseClient);

  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

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
      return UserModel.fromJson(response.user!.toJson()).copyWith(
          email: currentUserSession!.user.email
      );
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
      return UserModel.fromJson(response.user!.toJson()).copyWith(
          email: currentUserSession!.user.email
      );
    }catch (e){
      throw ServerException('Unexpected SignIn error: ${e.toString()}');
    }
  }

  @override
  Future<UserModel?> getCurrentUserData() async{
    try{
      if(currentUserSession != null){
        final userData = await supabaseClient.from('profiles').select()
            .eq('id', currentUserSession!.user.id);
        return UserModel.fromJson(userData.first).copyWith(
          email: currentUserSession!.user.email
        );
      }
      return null;
    }catch(e){
      throw ServerException(e.toString());
    }
  }
}