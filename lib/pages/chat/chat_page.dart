import 'package:flutter/material.dart';
import 'package:maritech/components/recvMessage.dart';
import 'package:maritech/components/sentMessage.dart';
import 'package:maritech/helpers/msg_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:uuid/uuid.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChatPage extends StatefulWidget {
  final String name;
  const ChatPage({super.key, required this.name});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late io.Socket socket;
  final TextEditingController _msgController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final Map<String, MsgModel> _messages = {};
  @override
  void initState() {
    super.initState();
    connect();
  }

  void connect() {
    socket = io.io(
      dotenv.env["WEBSOCKET_URL"],
      io.OptionBuilder()
          .setTransports(['websocket'])
          .enableAutoConnect()
          .build(),
    );
    socket.connect();
    socket.onConnect(
      (data) => {
        print("Connected"),
        // socket.emit("message", widget.name),
        socket.on(
          "message",
          (data) => {
            // print(data),
            setState(
              () {
                _messages[data["id"]] = MsgModel(
                  self: data["sender"] == widget.name,
                  message: data["message"],
                  sender: data["sender"],
                );
              },
            ),
            scrollDown(),
          },
        ),
        socket.on(
          "rate-limit",
          (data) => {
            setState(
              () {
                _messages[data]!.error = true;
              },
            ),
          },
        ),
      },
    );
  }

  void sendMessage() {
    if (_msgController.text.isNotEmpty) {
      var id = Uuid().v4();
      setState(
        () {
          _messages[id] = MsgModel(
            self: true,
            message: _msgController.text,
            sender: widget.name,
          );
        },
      );
      socket.emit(
        "message",
        {
          "id": id,
          "sender": widget.name,
          "message": _msgController.text,
        },
      );
      _msgController.clear();
      scrollDown();
    }
  }

  void scrollDown() {
    Future.delayed(
      const Duration(milliseconds: 100),
      () => _scrollController.jumpTo(
        _scrollController.position.maxScrollExtent,
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Chat Page")),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                String key = _messages.keys.elementAt(index);
                if (_messages[key]!.self) {
                  return SentMessage(
                    error: _messages[key]!.error,
                    sender: _messages[key]!.sender,
                    message: _messages[key]!.message,
                  );
                } else {
                  return RecvMessage(
                    sender: _messages[key]!.sender,
                    message: _messages[key]!.message,
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Type a message",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(50),
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                    ),
                    controller: _msgController,
                    onFieldSubmitted: (value) {
                      sendMessage();
                    },
                  ),
                ),
                IconButton(
                  onPressed: () {
                    sendMessage();
                  },
                  icon: const Icon(
                    Icons.send,
                    color: Colors.blue,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
