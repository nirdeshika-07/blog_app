import 'package:blog_app/core/secrets/supabase_secrets.dart';
import 'package:blog_app/core/theme/blog_theme.dart';
import 'package:blog_app/data/data_sources/auth_supabase_data_source.dart';
import 'package:blog_app/data/repositories/auth_repository_imple.dart';
import 'package:blog_app/domain/use_cases/user_signup.dart';
import 'package:blog_app/presentation/bloc/blog_auth_bloc.dart';
import 'package:blog_app/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // )
  final supabase = await Supabase.initialize(
      url: SupabaseSecret.supabaseUrl,
      anonKey: SupabaseSecret.anonKey,
  );
  runApp(
      MultiBlocProvider(
    providers: [
      BlocProvider(
          create: (_) => BlogAuthBloc(
              userSignUp: UserSignUp(
                  AuthRepositoryImple(
                      AuthSupabaseDataSourceImple(supabase.client)
                  )
              )
          )
      )
    ],
      child: const MyApp()
  ));
}
//get_it: ^9.0.5
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blog App',
      debugShowCheckedModeBanner: false,
      theme: BlogTheme.darkThemeMode,
      // ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      // ),
      home: LoginScreen(),
    );
  }
}

