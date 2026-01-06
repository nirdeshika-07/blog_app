part of 'blog_auth_bloc.dart';

@immutable
sealed class BlogAuthStates{
  const BlogAuthStates();
}

final class AuthInitial extends BlogAuthStates{}
final class AuthLoading extends BlogAuthStates{}
final class AuthSuccess extends BlogAuthStates{
  final User user;
  const AuthSuccess(this.user);
}
final class AuthFailure extends BlogAuthStates{
  final String message;
  const AuthFailure(this.message);
}