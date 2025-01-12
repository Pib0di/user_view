import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../model/user_data.dart';
import '../../utils/constants/endpoints.dart';

part 'public_client.g.dart';

@RestApi()
abstract class PublicClient {
  factory PublicClient(Dio dio) = _PublicClient;

  @GET(ApiEndpoints.users)
  Future<List<UserData>> getUsers({@Extras() Map<String, dynamic>? extras});
}
