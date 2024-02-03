part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

final class SupscripeMessageChannel extends ChatEvent {
  final String channelID;
  final SupscripeMessageChannelUseCase usecase;

  SupscripeMessageChannel({required this.channelID, required this.usecase});
}
