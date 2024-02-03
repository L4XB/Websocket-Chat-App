import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:websocket_chat/source/domain/entities/message_model.dart';
import 'package:websocket_chat/source/domain/usecases/get_history_messages.dart';

part 'chat_detail_event.dart';
part 'chat_detail_state.dart';

class ChatDetailBloc extends Bloc<ChatDetailEvent, ChatDetailState> {
  ChatDetailBloc() : super(ChatDetailInitial()) {
    on<SubscripeStream>(subscripeToMessageStream);
    on<LoadHistoryMessages>(loadHistoryMessagesFromWS);
  }

  FutureOr<void> subscripeToMessageStream(
      SubscripeStream event, Emitter<ChatDetailState> emit) async {
    try {
      await emit.forEach(event.stream, onData: (message) {
        Map<String, dynamic> jsonData = jsonDecode(message);
        return MessageRecived(message: MessageModel.fromJSON(jsonData));
      });
    } catch (e) {
      emit(SubscriptionFailed());
    }
  }

  FutureOr<void> loadHistoryMessagesFromWS(
      LoadHistoryMessages event, Emitter<ChatDetailState> emit) async {
    final channelID = event.channelID;
    try {
      List<MessageModel> historyMessages =
          await event.useCase.execute(channelID);
      emit(HistoryMessagesRecieved(historyMessages: historyMessages));
    } catch (e) {
      emit(LoadHistoryMessagesFailed());
    }
  }
}
