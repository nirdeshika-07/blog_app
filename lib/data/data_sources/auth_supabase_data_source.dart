import 'package:blog_app/core/error/exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthSupabaseDataSource{
  Future<String> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password
  });
  Future<String> signInWithEmailPassword({
    required String email,
    required String password
  });
}

class AuthSupabaseDataSourceImple implements AuthSupabaseDataSource{
  final SupabaseClient supabaseClient ;
  AuthSupabaseDataSourceImple(this.supabaseClient);

  @override
  Future<String> signUpWithEmailPassword({
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
      return response.user!.id;
    }catch(e){
      throw ServerException('Unexpected SignUp error: ${e.toString()}');
    }
  }
  @override
  Future<String> signInWithEmailPassword({
    required String email,
    required String password
  }){
    //TODO
    throw UnimplementedError();
  }
}