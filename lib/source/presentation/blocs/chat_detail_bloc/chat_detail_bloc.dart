import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'chat_detail_event.dart';
part 'chat_detail_state.dart';

class ChatDetailBloc extends Bloc<ChatDetailEvent, ChatDetailState> {
  ChatDetailBloc() : super(ChatDetailInitial()) {
    on<ChatDetailEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
