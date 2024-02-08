import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:websocket_chat/source/domain/entities/message_model.dart';
import 'package:websocket_chat/source/domain/usecases/add_message_channel.dart';
import 'package:websocket_chat/source/domain/usecases/get_channel_ids.dart';
import 'package:websocket_chat/source/domain/usecases/supscripe_message_channel.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial()) {
    on<SupscripeMessageChannel>(supscripeToSpecificChannel);
    on<AddMessageChannel>(addNewMessageChannel);
    on<LoadAllMesageChannels>(loadAllMessageChannels);
  }

  FutureOr<void> supscripeToSpecificChannel(
      SupscripeMessageChannel event, Emitter<ChatState> emit) async {
    final useCase = event.usecase;
    final channelID = event.channelID;
    try {
      Stream<dynamic> messageStream = await useCase.execute(channelID);
      emit(SubscriptionSuccesfull(messageStream: messageStream));
    } catch (e) {
      emit(SubscriptionFailed());
    }
  }

  FutureOr<void> addNewMessageChannel(
      AddMessageChannel event, Emitter<ChatState> emit) async {
    final AddMessageChannelUseCase addChannelUseCase = event.addChanneluseCase;
    final GetChannelIDsUseCase getChannelIDs = event.getChannelsUseCase;
    final String channelName = event.channelName;
    try {
      addChannelUseCase.execute([channelName]);
      final List<String>? allChannels = await getChannelIDs.execute();

      emit(ChannelAddedSuccesfully(channelNamens: allChannels!));
    } catch (e) {
      emit(ChannelAddingFailed());
    }
  }

  FutureOr<void> loadAllMessageChannels(
      LoadAllMesageChannels event, Emitter<ChatState> emit) async {
    final GetChannelIDsUseCase getChannelIDs = event.getChannelsUseCase;
    try {
      final List<String>? allChannels = await getChannelIDs.execute();
      emit(ChannelsLoadedSuccefully(channelNamens: allChannels!));
    } catch (e) {
      emit(ChannelsLoadingFailed());
    }
  }
}
