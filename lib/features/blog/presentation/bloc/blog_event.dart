part of 'blog_bloc.dart';

@immutable
sealed class BlogEvent {}

final class BlogUpload extends BlogEvent {
  final String userId;
  final String blogTitle;
  final String blogContent;
  final File image;
  final List<String> topics;

  BlogUpload({
    required this.userId,
    required this.blogTitle,
    required this.blogContent,
    required this.image,
    required this.topics,
  });
}

final class BlogFetchAllBlogs extends BlogEvent {}