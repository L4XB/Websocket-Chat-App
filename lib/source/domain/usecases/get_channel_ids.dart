import 'package:websocket_chat/source/data/repositories/shared_prefs_repository.dart';

class GetChannelIDsUseCase {
  final SharedPrefsRepository repository;

  GetChannelIDsUseCase({required this.repository});

  Future<List<String>?> execute() async {
    final List<String>? channelIDs = await repository.getChannelIDs();
    return channelIDs;
  }
}
