import 'package:blog_app/domain/entities/user.dart';
import 'package:blog_app/domain/use_cases/user_login.dart';
import 'package:blog_app/domain/use_cases/user_signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_auth_states.dart';
part 'blog_auth_event.dart';

class BlogAuthBloc extends Bloc<BlogAuthEvent, BlogAuthStates>{
  final UserSignUp _userSignUp;
  final UserSignIn _userSignIn;

  BlogAuthBloc({
    required UserSignUp userSignUp,
    required UserSignIn userSignIn,
  }) : _userSignUp= userSignUp, //Initializer List
  _userSignIn = userSignIn,
        super(AuthInitial()){
   on<BlogAuthSignUp> ((event, emit) async{
     emit(AuthLoading());
    final response = await _userSignUp(
        UserSignUpParams(
        email: event.email,
        password: event.password,
        name: event.name)
    );
    
    response.fold(
            (failure) => emit(AuthFailure(failure.message)),
            (user) {
              emit(AuthSuccess(user));
            }
    );
   });
   on<BlogAuthSignIn> ((event, emit) async{
     emit(AuthLoading());
    final response = await _userSignIn(
        UserSignInParams(
        email: event.email,
        password: event.password
        ),
    );

    response.fold(
            (failure) => emit(AuthFailure(failure.message)),
            (user) {
              emit(AuthSuccess(user));
            }
    );
   });
  }
}