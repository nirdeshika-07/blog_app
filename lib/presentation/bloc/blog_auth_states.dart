part of 'blog_auth_bloc.dart';

@immutable
sealed class BlogAuthStates{
  const BlogAuthStates();
}

final class AuthInitial extends BlogAuthStates{}
final class AuthLoading extends BlogAuthStates{}
final class AuthSuccess extends BlogAuthStates{
  final String uid;
  const AuthSuccess(this.uid);
}
final class AuthFailure extends BlogAuthStates{
  final String message;
  const AuthFailure(this.message);
}