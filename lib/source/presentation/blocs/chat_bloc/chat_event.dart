part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

final class SupscripeMessageChannel extends ChatEvent {
  final String channelID;
  final SupscripeMessageChannelUseCase usecase;

  SupscripeMessageChannel({required this.channelID, required this.usecase});
}

final class AddMessageChannel extends ChatEvent {
  final String channelName;
  final AddMessageChannelUseCase addChanneluseCase;
  final GetChannelIDsUseCase getChannelsUseCase;

  AddMessageChannel(
      {required this.channelName,
      required this.addChanneluseCase,
      required this.getChannelsUseCase});
}

final class LoadAllMesageChannels extends ChatEvent {
  final GetChannelIDsUseCase getChannelsUseCase;

  LoadAllMesageChannels({required this.getChannelsUseCase});
}
