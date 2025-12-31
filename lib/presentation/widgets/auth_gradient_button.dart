import 'package:blog_app/core/theme/blog_pallete.dart';
import 'package:flutter/material.dart';

class AuthGradientButton extends StatelessWidget {
  const AuthGradientButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              BlogPallete.gradient1,
              BlogPallete.gradient2,
              BlogPallete.gradient3
            ]),
        borderRadius: BorderRadius.circular(10)
      ),
      child: ElevatedButton(
          onPressed: (){},
        style: ElevatedButton.styleFrom(
          fixedSize: Size(395,55 ),
          backgroundColor: BlogPallete.transparentColor,
          shadowColor: BlogPallete.transparentColor
        ),
        child: Text(
            'Sign Up',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600
          ),
        ),
      ),
    );
  }
}
