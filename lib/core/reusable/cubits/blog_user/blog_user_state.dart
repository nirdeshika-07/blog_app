part of 'blog_user_cubit.dart';

@immutable
sealed class BlogUserState{
  const BlogUserState();
}
final class BlogUserInitial extends BlogUserState{}
final class BlogUserLoading extends BlogUserState{}
final class BlogUserSignedIn extends BlogUserState{
  final User user;
  const BlogUserSignedIn(this.user);
}
final class BlogUserFailure extends BlogUserState{}