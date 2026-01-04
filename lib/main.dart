import 'package:blog_app/core/reusable/cubits/blog_user/blog_user_cubit.dart';
import 'package:blog_app/core/theme/blog_theme.dart';
import 'package:blog_app/features/blog/data/presentation/screens/blog_screen.dart';
import 'package:blog_app/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/auth/presentation/bloc/blog_auth_bloc.dart';
import 'features/auth/presentation/screens/login_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(
      MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => serviceLocator<BlogUserCubit>()),
      BlocProvider(create: (_) => serviceLocator<BlogAuthBloc>())
    ],
      child: const MyApp()
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<BlogAuthBloc>().add(BlogAuthIsUserSignedIn());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blog App',
      debugShowCheckedModeBanner: false,
      theme: BlogTheme.darkThemeMode,
      // ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      // ),
      home: BlocSelector<BlogUserCubit, BlogUserState, bool>(
        selector: (state){
          return state is BlogUserSignedIn;
        },
        builder: (context, isSignedIn) {
          if(isSignedIn){
            return const BlogScreen();
          }
          else{
            return const LoginScreen();
          }
        }
      ),
    );
  }
}

