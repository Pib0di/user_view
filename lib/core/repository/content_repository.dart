import 'package:user_view/core/api/rest_api/public_client.dart';
import 'package:user_view/core/model/user_data.dart';
import 'package:user_view/core/utils/tools/requets_wrapper.dart';

class ContentRepository {
  final PublicClient _publicClient;

  ContentRepository(this._publicClient);

  Future<List<UserData>?> getUsers({Map<String, dynamic>? extras}) async =>
      appToastWrapper(() => _publicClient.getUsers(extras: extras));
}
