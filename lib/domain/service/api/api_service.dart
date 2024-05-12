/* import 'package:contactly/core/consts/app_consts.dart';
import 'package:contactly/features/model/contact_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: AppConsts.baseUrl)
abstract class ApiServiceClient {
  factory ApiServiceClient(Dio dio, {String baseUrl}) = _ApiServiceClient;

  @GET("/User?apiKey={apiKey}&accept={accept}")
  Future<List<ContactModel>> fetch(
      @Header('ApiKey') String apiKey, @Header('accept') String accept);

  @POST('/User')
  Future<void> saveUser(ContactModel contact);
}
 */