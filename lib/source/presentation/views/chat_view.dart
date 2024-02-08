import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:websocket_chat/source/common/constants/style_constants.dart';
import 'package:websocket_chat/source/data/repositories/shared_prefs_repository.dart';
import 'package:websocket_chat/source/data/repositories/websocket_repositorie.dart';
import 'package:websocket_chat/source/domain/usecases/add_message_channel.dart';
import 'package:websocket_chat/source/domain/usecases/get_channel_ids.dart';
import 'package:websocket_chat/source/domain/usecases/supscripe_message_channel.dart';
import 'package:websocket_chat/source/presentation/blocs/chat_bloc/chat_bloc.dart';
import 'package:websocket_chat/source/presentation/views/chat_detail_view.dart';
import 'package:websocket_chat/source/presentation/widgets/chat_widgets/home_default_layout.dart';

class ChatView extends StatefulWidget {
  final WebsocketRepositorie repositorie;
  final SharedPrefsRepository sharedPrefsRepository;
  const ChatView(
      {super.key,
      required this.repositorie,
      required this.sharedPrefsRepository});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  late SupscripeMessageChannelUseCase useCase;
  late TextEditingController channelController;
  late AddMessageChannelUseCase addMessageChannelUseCase;
  late GetChannelIDsUseCase getChannelsUseCase;

  @override
  void initState() {
    useCase = SupscripeMessageChannelUseCase(repositorie: widget.repositorie);
    channelController = TextEditingController();
    addMessageChannelUseCase =
        AddMessageChannelUseCase(repository: widget.sharedPrefsRepository);
    getChannelsUseCase =
        GetChannelIDsUseCase(repository: widget.sharedPrefsRepository);
    context
        .read<ChatBloc>()
        .add(LoadAllMesageChannels(getChannelsUseCase: getChannelsUseCase));
    super.initState();
  }

  @override
  void dispose() {
    channelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () => _addNewChannel(channelController.text,
              addMessageChannelUseCase, getChannelsUseCase),
          child: const Icon(Icons.add)),
      appBar: StyleConstants().buildAppBar("Chat Overview"),
      body: BlocConsumer<ChatBloc, ChatState>(
        builder: (context, state) => _buildBody(context, state),
        listener: (context, state) => _triggerEvents(context, state),
      ),
    );
  }

  _buildBody(BuildContext context, ChatState state) {
    return HomeDefaultLayout(
      channelController: channelController,
      useCase: useCase,
      repositorie: widget.repositorie,
    );
  }

  _triggerEvents(
    BuildContext context,
    ChatState state,
  ) async {
    if (state is SubscriptionSuccesfull) {
      debugPrint("Succefully Connected");
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatDetailView(
              messageStream: state.messageStream,
              getChannelIDsUseCase: getChannelsUseCase,
              repositorie: widget.repositorie,
              channelID: state.channelName),
        ),
      );

      // ignore: use_build_context_synchronously
      _triggerNewLoadOfChannels(context);
    }
  }

  void _addNewChannel(
      String channelName,
      AddMessageChannelUseCase addChanneluseCase,
      GetChannelIDsUseCase getChannelsUseCase) {
    context.read<ChatBloc>().add(AddMessageChannel(
        channelName: channelName,
        addChanneluseCase: addChanneluseCase,
        getChannelsUseCase: getChannelsUseCase));
  }

  _triggerNewLoadOfChannels(BuildContext context) {
    context
        .read<ChatBloc>()
        .add(LoadAllMesageChannels(getChannelsUseCase: getChannelsUseCase));
  }
}
