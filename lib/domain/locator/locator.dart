/* import 'package:contactly/domain/repository/repository.dart';
import 'package:contactly/domain/service/api/api_service.dart';
import 'package:contactly/features/viewmodel/service/cubit/service_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void locator() {
  Dio dio = Dio();
  getIt.registerLazySingleton(() => dio);

  ApiServiceClient appServiceClient = ApiServiceClient(getIt.call());
  getIt.registerLazySingleton(() => appServiceClient);

  Repository repository = Repository(getIt.call());
  getIt.registerLazySingleton(() => repository);

  ServiceCubit getCatsCubit = ServiceCubit(getIt.call());
  getIt.registerLazySingleton(() => getCatsCubit);
}
 */