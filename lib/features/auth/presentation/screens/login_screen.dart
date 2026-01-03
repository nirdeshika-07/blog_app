import 'package:blog_app/core/reusable/widgets/loading.dart';
import 'package:blog_app/core/theme/blog_pallete.dart';
import 'package:blog_app/core/utils/show_snackbar.dart';
import 'package:blog_app/features/auth/presentation/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/blog_auth_bloc.dart';
import '../widgets/auth_field.dart';
import '../widgets/auth_gradient_button.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  static route() => MaterialPageRoute(
      builder: (context) => const SignupScreen()
  );
  static route1() => MaterialPageRoute(
      builder: (context) => const MyHomePage(title: "Success")
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
        child: BlocConsumer<BlogAuthBloc, BlogAuthStates>(
          listener: (context, state){
            if(state is AuthFailure){
              showSnackBar(context, state.message);
            }
          },
          builder: (context, state) {
            if(state is AuthLoading){
              return const Loading();
            }
            return Form(
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
                      if(formKey.currentState!.validate()){
                        context.read<BlogAuthBloc>().add(
                            BlogAuthSignIn(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim()
                            )
                        );
                        // Navigator.push(context, LoginScreen.route1());
                      }

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
            );
          }
        ),
      ),
    );
  }
}
