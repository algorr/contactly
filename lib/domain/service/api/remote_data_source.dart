/* import 'package:contactly/domain/service/api/api_service.dart';
import 'package:contactly/features/model/contact_model.dart';
import 'package:contactly/product/init/config/app_environment.dart';

abstract class RemoteDataSource {
  Future<List<ContactModel>> fetchCats();
}

class RemoteDataSourceImplementer implements RemoteDataSource {
  RemoteDataSourceImplementer(this._appServiceClient);
  final ApiServiceClient _appServiceClient;

  @override
  Future<List<ContactModel>> fetchCats() {
    return _appServiceClient.fetch(
        AppEnvironmentItems.apiKey.value, 'text/plain');
  }
}
 */