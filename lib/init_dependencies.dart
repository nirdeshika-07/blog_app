import 'package:blog_app/core/reusable/cubits/blog_user/blog_user_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/network/connection_checker.dart';
import 'core/secrets/supabase_secrets.dart';
import 'features/auth/data/data_sources/auth_supabase_data_source.dart';
import 'features/auth/data/repositories/auth_repository_imple.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/use_cases/current_user.dart';
import 'features/auth/domain/use_cases/user_login.dart';
import 'features/auth/domain/use_cases/user_signup.dart';
import 'features/auth/presentation/bloc/blog_auth_bloc.dart';
import 'features/blog/data/datasources/blog_local_data_source.dart';
import 'features/blog/data/datasources/blog_supabase_data_source.dart';
import 'features/blog/data/repositories/blog_repositories_imple.dart';
import 'features/blog/domain/repositories/blog_repositories.dart';
import 'features/blog/domain/usecases/get_all_blogs.dart';
import 'features/blog/domain/usecases/upload_blogs.dart';
import 'features/blog/presentation/bloc/blog_bloc.dart';

part 'init_dependencies.main.dart';
// final serviceLocator = GetIt.instance;
//
// Future<void> initDependencies() async {
//   _initAuth();
//   final supabase = await Supabase.initialize(
//     url: SupabaseSecret.supabaseUrl,
//     anonKey: SupabaseSecret.anonKey,
//   );
//   serviceLocator.registerLazySingleton(() => supabase.client);
//
//   //Service Locator of Core
//   serviceLocator.registerLazySingleton(() => BlogUserCubit());
// }
//
