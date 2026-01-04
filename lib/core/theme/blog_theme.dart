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
    appBarTheme:const AppBarTheme(
      backgroundColor: BlogPallete.backgroundColor
    ),
    chipTheme: ChipThemeData(
      color: WidgetStatePropertyAll(BlogPallete.backgroundColor),
          selectedColor: BlogPallete.gradient1,
      side: BorderSide.none
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27),
      enabledBorder: _border(),
        focusedBorder: _border(BlogPallete.gradient2)
    )
  );
}