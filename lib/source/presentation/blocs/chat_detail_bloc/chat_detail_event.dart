part of 'chat_detail_bloc.dart';

@immutable
sealed class ChatDetailEvent {}

final class SubscripeStream extends ChatDetailEvent {
  final Stream<dynamic> stream;

  SubscripeStream({required this.stream});
}

final class LoadHistoryMessages extends ChatDetailEvent {
  final String channelID;
  final GetHistoryMessagesUseCase useCase;

  LoadHistoryMessages({required this.channelID, required this.useCase});
}

final class SendMessage extends ChatDetailEvent {
  final String channelID;
  final MessageModel messageModel;
  final SendMessageUseCase useCase;

  SendMessage(
      {required this.channelID,
      required this.messageModel,
      required this.useCase});
}
