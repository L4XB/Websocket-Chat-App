import 'package:websocket_chat/source/data/repositories/shared_prefs_repository.dart';

class AddMessageChannelUseCase {
  final SharedPrefsRepository repository;

  AddMessageChannelUseCase({required this.repository});

  void execute(List<String> channelIDs) async {
    await repository.addChannelIDs(channelIDs);
  }
}
