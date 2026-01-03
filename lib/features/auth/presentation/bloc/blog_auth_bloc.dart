import 'package:blog_app/core/usecase/use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/user.dart';
import '../../domain/use_cases/current_user.dart';
import '../../domain/use_cases/user_login.dart';
import '../../domain/use_cases/user_signup.dart';

part 'blog_auth_states.dart';
part 'blog_auth_event.dart';

class BlogAuthBloc extends Bloc<BlogAuthEvent, BlogAuthStates>{
  final UserSignUp _userSignUp;
  final UserSignIn _userSignIn;
  final CurrentUser _currentUser;

  BlogAuthBloc({
    required UserSignUp userSignUp,
    required UserSignIn userSignIn,
    required CurrentUser currentUser,
  }) : _userSignUp= userSignUp, //Initializer List
        _userSignIn = userSignIn,
        _currentUser = currentUser,
        super(AuthInitial()){
   on<BlogAuthSignUp> ((event, emit) async{
     emit(AuthLoading());
    final result = await _userSignUp(
        UserSignUpParams(
        email: event.email,
        password: event.password,
        name: event.name)
    );
    
    result.fold(
            (failure) => emit(AuthFailure(failure.message)),
            (user) {
              emit(AuthSuccess(user));
            }
    );
   });
   on<BlogAuthSignIn> ((event, emit) async{
     emit(AuthLoading());
    final result = await _userSignIn(
        UserSignInParams(
        email: event.email,
        password: event.password
        ),
    );

    result.fold(
            (failure) => emit(AuthFailure(failure.message)),
            (user) {
              emit(AuthSuccess(user));
            }
    );
   });
  on<BlogAuthIsUserSignedIn> ((event, emit) async{
     emit(AuthLoading());
    final result = await _currentUser(NoParams());

    result.fold(
            (failure) => emit(AuthFailure(failure.message)),
            (user) {
              emit(AuthSuccess(user));
            }
    );
   });
  }
}