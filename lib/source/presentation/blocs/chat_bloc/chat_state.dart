part of 'chat_bloc.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class MessageRecived extends ChatState {
  final MessageModel message;

  MessageRecived({required this.message});
}

final class SubscriptionFailed extends ChatState {}

final class SubscriptionSuccesfull extends ChatState {
  final Stream<dynamic> messageStream;
  final String channelName;

  SubscriptionSuccesfull(
      {required this.messageStream, required this.channelName});
}

final class ChannelAddedSuccesfully extends ChatState {
  final List<String> channelNamens;

  ChannelAddedSuccesfully({required this.channelNamens});
}

final class ChannelAddingFailed extends ChatState {}

final class ChannelsLoadedSuccefully extends ChatState {
  final List<String> channelNamens;

  ChannelsLoadedSuccefully({required this.channelNamens});
}

final class ChannelsLoadingFailed extends ChatState {}
