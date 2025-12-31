import 'package:blog_app/core/theme/blog_pallete.dart';
import 'package:flutter/material.dart';

class BlogTheme{
  static _border([Color color = BlogPallete.borderColor]) => OutlineInputBorder(
      borderSide: BorderSide(
          color: color,
          width: 3
      ),
      borderRadius: BorderRadius.circular(10)
  );

  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: BlogPallete.backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27),
      enabledBorder: _border(),
        focusedBorder: _border(BlogPallete.gradient2)
    )
  );
}