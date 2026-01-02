import 'package:blog_app/domain/use_cases/user_signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_auth_states.dart';
part 'blog_auth_event.dart';

class BlogAuthBloc extends Bloc<BlogAuthEvent, BlogAuthStates>{
  final UserSignUp _userSignUp;

  BlogAuthBloc({
    required UserSignUp userSignUp,
  }) : _userSignUp= userSignUp, //Initializer List 
        super(AuthInitial()){
   on<BlogAuthSignUp> ((event, emit) async{
    final response = await _userSignUp(
        UserSignUpParams(
        email: event.email,
        password: event.password,
        name: event.name)
    );
    
    response.fold((failure) => emit(AuthFailure(failure.message)), (uid) => emit(AuthSuccess(uid)));
   });
  }
}