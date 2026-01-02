import 'package:blog_app/core/theme/blog_pallete.dart';
import 'package:blog_app/presentation/screens/signup_screen.dart';
import 'package:blog_app/presentation/widgets/auth_field.dart';
import 'package:blog_app/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static route() => MaterialPageRoute(
      builder: (context) => const SignupScreen()
  );
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();// Let flutter dispose rest of the remaining state
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width*0.02
        ),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sign In',
                style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              AuthField(hintText: 'Enter Email', controller: emailController,),
              const SizedBox(
                height: 15,
              ),
              AuthField(hintText: 'Enter Password', controller: passwordController, isObscureText: true,),
              const SizedBox(
                height: 15,
              ),
              AuthGradientButton(
                textValue: 'Sign In',
                onPressed: (){

                },
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, LoginScreen.route());
                },
                child: RichText(
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
