import 'package:blog_app/data/data_sources/auth_supabase_data_source.dart';
import 'package:blog_app/data/repositories/auth_repository_imple.dart';
import 'package:blog_app/domain/repositories/auth_repository.dart';
import 'package:blog_app/domain/use_cases/user_login.dart';
import 'package:blog_app/domain/use_cases/user_signup.dart';
import 'package:blog_app/presentation/bloc/blog_auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/secrets/supabase_secrets.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
    url: SupabaseSecret.supabaseUrl,
    anonKey: SupabaseSecret.anonKey,
  );
  serviceLocator.registerLazySingleton(() => supabase.client);
}

void _initAuth() {
  serviceLocator.registerFactory<AuthSupabaseDataSource>(() => AuthSupabaseDataSourceImple(
    serviceLocator(),
  ),
  );
  serviceLocator.registerFactory<AuthRepository>(() => AuthRepositoryImple(
    serviceLocator()
  ));
  serviceLocator.registerFactory(() => UserSignUp(
      serviceLocator(),
  ));
  serviceLocator.registerFactory(() => UserSignIn(
      serviceLocator(),
  ));
  serviceLocator.registerLazySingleton(() => BlogAuthBloc(
      userSignUp: serviceLocator(),
    userSignIn: serviceLocator()
  ));
}