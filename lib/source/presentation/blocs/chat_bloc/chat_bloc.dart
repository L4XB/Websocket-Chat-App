import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:websocket_chat/source/domain/entities/message_model.dart';
import 'package:websocket_chat/source/domain/usecases/supscripe_message_channel.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial()) {
    on<SupscripeMessageChannel>(supscripeToSpecificChannel);
  }

  FutureOr<void> supscripeToSpecificChannel(
      SupscripeMessageChannel event, Emitter<ChatState> emit) async {
    final useCase = event.usecase;
    final channelID = event.channelID;
    try {
      Stream<dynamic> stream = await useCase.execute(channelID);
      emit(SubscriptionSuccesfull());

      await emit.forEach(stream, onData: (message) {
        Map<String, dynamic> jsonData = jsonDecode(message);
        return MessageRecived(message: MessageModel.fromJSON(jsonData));
      });
    } catch (e) {
      emit(SubscriptionFailed());
    }
  }
}
