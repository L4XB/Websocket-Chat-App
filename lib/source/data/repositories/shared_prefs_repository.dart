import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsRepository {
  Future<void> insertChannelIDs(List<String> channelIDs) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setStringList("channelIDs", channelIDs);
  }

  Future<List<String>?> getChannelIDs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final List<String>? channelIDs = prefs.getStringList("channelIDs");
    if (channelIDs == null) {
      return [];
    }
    return channelIDs;
  }

  Future<void> addChannelIDs(List<String> channelIDs) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> existingChannelIDs =
        prefs.getStringList("channelIDs") ?? [];
    existingChannelIDs.addAll(channelIDs);
    await prefs.setStringList("channelIDs", existingChannelIDs);
  }
}
