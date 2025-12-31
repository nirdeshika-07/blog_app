import 'package:blog_app/core/theme/blog_pallete.dart';
import 'package:blog_app/presentation/widgets/auth_field.dart';
import 'package:blog_app/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width*0.02
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                'Sign In',
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            AuthField(hintText: 'Enter Name'),
            const SizedBox(
              height: 15,
            ),
            AuthField(hintText: 'Enter Email'),
            const SizedBox(
              height: 15,
            ),
            AuthField(hintText: 'Enter Password'),
            const SizedBox(
              height: 15,
            ),
            AuthGradientButton(),
            const SizedBox(
              height: 15,
            ),
            RichText(
                text: TextSpan(
              text: 'Don\'t have an account? ',
                  style: Theme.of(context).textTheme.titleMedium,
                  children: [
                    TextSpan(
                      text: 'Sign Up',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: BlogPallete.gradient3,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ]
            ),
            )
          ],
        ),
      ),
    );
  }
}
