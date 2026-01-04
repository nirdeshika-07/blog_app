import 'package:blog_app/core/reusable/cubits/blog_user/blog_user_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/secrets/supabase_secrets.dart';
import 'features/auth/data/data_sources/auth_supabase_data_source.dart';
import 'features/auth/data/repositories/auth_repository_imple.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/use_cases/current_user.dart';
import 'features/auth/domain/use_cases/user_login.dart';
import 'features/auth/domain/use_cases/user_signup.dart';
import 'features/auth/presentation/bloc/blog_auth_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
    url: SupabaseSecret.supabaseUrl,
    anonKey: SupabaseSecret.anonKey,
  );
  serviceLocator.registerLazySingleton(() => supabase.client);

  //Service Locator of Core
  serviceLocator.registerLazySingleton(() => BlogUserCubit());
}

void _initAuth() {
  serviceLocator
  //Data Source
      ..registerFactory<AuthSupabaseDataSource>(() => AuthSupabaseDataSourceImple(
    serviceLocator(),
  ))
    //Repository
  ..registerFactory<AuthRepository>(() => AuthRepositoryImple(
    serviceLocator()
  ))
    //Use cases
  ..registerFactory(() => UserSignUp(
      serviceLocator(),
  ))
  ..registerFactory(() => UserSignIn(
      serviceLocator(),
  ))
    ..registerFactory(() => CurrentUser(
      serviceLocator(),
  ))
    //Bloc
  ..registerLazySingleton(() => BlogAuthBloc(
      userSignUp: serviceLocator(),
    userSignIn: serviceLocator(),
    currentUser: serviceLocator(),
    blogUserCubit: serviceLocator()
  ));
}