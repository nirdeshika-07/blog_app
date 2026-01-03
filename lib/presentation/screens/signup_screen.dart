import 'package:blog_app/core/reusable/widgets/loading.dart';
import 'package:blog_app/core/theme/blog_pallete.dart';
import 'package:blog_app/core/utils/show_snackbar.dart';
import 'package:blog_app/presentation/bloc/blog_auth_bloc.dart';
import 'package:blog_app/presentation/screens/login_screen.dart';
import 'package:blog_app/presentation/widgets/auth_field.dart';
import 'package:blog_app/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupScreen extends StatefulWidget {
  static route() => MaterialPageRoute(
    builder: (context) => LoginScreen()
  );
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();// Let flutter dispose rest of the remaining state
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width*0.02
          ),
          child:
            BlocConsumer<BlogAuthBloc, BlogAuthStates>(
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
                        'Sign Up',
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    AuthField(hintText: 'Enter Name', controller: nameController,),
                    const SizedBox(
                      height: 15,
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
                      textValue: 'Sign Up',
                      onPressed: (){
                        if(formKey.currentState!.validate()){
                          context.read<BlogAuthBloc>().add(
                              BlogAuthSignUp(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                  name: nameController.text.trim()
                              ));
                          Navigator.push(context, SignupScreen.route());
                        }
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, SignupScreen.route());
                      },
                      child: RichText(
                        text: TextSpan(
                        text: 'Already have an account? ',
                            style: Theme.of(context).textTheme.titleMedium,
                            children: [
                              TextSpan(
                                text: 'Sign In',
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
      ),
    );
  }
}
