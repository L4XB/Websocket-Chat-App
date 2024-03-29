part of 'chat_detail_bloc.dart';

@immutable
sealed class ChatDetailState {}

final class ChatDetailInitial extends ChatDetailState {}

/// [SubscripteStream]
final class MessageRecived extends ChatDetailState {
  final MessageModel message;

  MessageRecived({required this.message});
}

final class SubscriptionFailed extends ChatDetailState {}

final class SubscriptionSuccesfull extends ChatDetailState {}

/// [LoadingHistory]
final class HistoryMessagesRecieved extends ChatDetailState {
  final List<MessageModel> historyMessages;

  HistoryMessagesRecieved({required this.historyMessages});
}

final class LoadHistoryMessagesFailed extends ChatDetailState {}

/// [MessageSending]
final class MessageSendedSuccefully extends ChatDetailState {
  final MessageModel messageModel;

  MessageSendedSuccefully({required this.messageModel});
}

final class SendingMessageFailed extends ChatDetailState {}
