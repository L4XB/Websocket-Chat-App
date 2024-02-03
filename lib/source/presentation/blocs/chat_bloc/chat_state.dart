part of 'chat_bloc.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class MessageRecived extends ChatState {
  final MessageModel message;

  MessageRecived({required this.message});
}

final class SubscriptionFailed extends ChatState {}

final class SubscriptionSuccesfull extends ChatState {}
