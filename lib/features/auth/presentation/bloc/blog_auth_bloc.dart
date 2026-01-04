import 'package:blog_app/core/reusable/cubits/blog_user/blog_user_cubit.dart';
import 'package:blog_app/core/usecase/use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/reusable/entities/user.dart';
import '../../domain/use_cases/current_user.dart';
import '../../domain/use_cases/user_login.dart';
import '../../domain/use_cases/user_signup.dart';

part 'blog_auth_states.dart';
part 'blog_auth_event.dart';

class BlogAuthBloc extends Bloc<BlogAuthEvent, BlogAuthStates>{
  final UserSignUp _userSignUp;
  final UserSignIn _userSignIn;
  final CurrentUser _currentUser;
  final BlogUserCubit _blogUserCubit;

  BlogAuthBloc({
    required UserSignUp userSignUp,
    required UserSignIn userSignIn,
    required CurrentUser currentUser,
    required BlogUserCubit blogUserCubit,
  }) : _userSignUp= userSignUp, //Initializer List
        _userSignIn = userSignIn,
        _currentUser = currentUser,
        _blogUserCubit = blogUserCubit,
        super(AuthInitial()){

    on<BlogAuthEvent> ((_, emit){
      emit(AuthLoading());
    });


   on<BlogAuthSignUp> ((event, emit) async{
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
    final result = await _userSignIn(
        UserSignInParams(
        email: event.email,
        password: event.password
        ),
    );

    result.fold(
            (failure) => emit(AuthFailure(failure.message)),
            (user) {
              _emitAuthSuccess(user, emit);
            }
    );
   });
  on<BlogAuthIsUserSignedIn> ((event, emit) async{
    final result = await _currentUser(NoParams());

    result.fold(
            (failure) => emit(AuthFailure(failure.message)),
            (user) {
              _emitAuthSuccess(user, emit);
            }
    );
   });
  }

  void _emitAuthSuccess(User user, Emitter<BlogAuthStates> emit){
    _blogUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }
}