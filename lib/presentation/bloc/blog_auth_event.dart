part of 'blog_auth_bloc.dart';

@immutable
sealed class BlogAuthEvent{}
final class BlogAuthSignUp extends BlogAuthEvent{
  final String email;
  final String password;
  final String name;

  BlogAuthSignUp({
    required this.email,
    required this.password,
    required this.name,
  });
}