import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsRepository {
  Future<void> insertChannelIDs(List<String> channelIDs) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setStringList("channelIDs", channelIDs);
  }

  Future<List<String>?> getChannelIDs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String>? channelIDs = prefs.getStringList("channelIDs");

    return channelIDs;
  }
}
