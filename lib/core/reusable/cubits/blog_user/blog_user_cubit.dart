import 'package:blog_app/core/reusable/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_user_state.dart';

class BlogUserCubit extends Cubit<BlogUserState>{
  BlogUserCubit() : super(BlogUserInitial());
  void updateUser(User? user){
    if(user == null){
      emit(BlogUserInitial());
    } else{
      emit(BlogUserSignedIn(user));
    }
  }
}