import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:websocket_chat/source/domain/entities/message_model.dart';

part 'chat_detail_event.dart';
part 'chat_detail_state.dart';

class ChatDetailBloc extends Bloc<ChatDetailEvent, ChatDetailState> {
  ChatDetailBloc() : super(ChatDetailInitial()) {
    on<SubscripeStream>(subscripeToMessageStream);
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
}
