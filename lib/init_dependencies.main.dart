part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initBlog();

  final supabase = await Supabase.initialize(
    url: SupabaseSecret.supabaseUrl,
    anonKey: SupabaseSecret.anonKey,
  );

  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;

  serviceLocator.registerLazySingleton(() => supabase.client);

  serviceLocator.registerLazySingleton(
        () => Hive.box(name: 'blogs'),
  );

  serviceLocator.registerFactory(() => InternetConnection());

  // core
  serviceLocator.registerLazySingleton(
        () => BlogUserCubit(),
  );
  serviceLocator.registerFactory<ConnectionChecker>(
        () => ConnectionCheckerImpl(
      serviceLocator(),
    ),
  );
}

void _initAuth() {
  serviceLocator
  //Data Source
    ..registerFactory<AuthSupabaseDataSource>(() => AuthSupabaseDataSourceImple(
    serviceLocator(),
  ))
    //Repository
  ..registerFactory<AuthRepository>(() => AuthRepositoryImple(
    serviceLocator(),
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

void _initBlog() {
  serviceLocator
  // Datasource
    ..registerFactory<BlogSupabaseDataSource>(
          () => BlogSupabaseDataSourceImple(
        serviceLocator(),
      ),
    )
    ..registerFactory<BlogLocalDataSource>(
          () => BlogLocalDataSourceImpl(
        serviceLocator(),
      ),
    )
  // Repository
    ..registerFactory<BlogRepository>(
          () => BlogRepositoryImple(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ),
    )
  // Usecases
    ..registerFactory(
          () => UploadBlog(
        serviceLocator(),
      ),
    )
    ..registerFactory(
          () => GetAllBlogs(
        serviceLocator(),
      ),
    )
  // Bloc
    ..registerLazySingleton(
          () => BlogBloc(
        uploadBlog: serviceLocator(),
        getAllBlogs: serviceLocator(),
      ),
    );
}