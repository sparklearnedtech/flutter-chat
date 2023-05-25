class MsgModel {
  bool error = false;
  bool self = false;
  String message = '';
  String sender = '';
  MsgModel({required this.self, required this.message, required this.sender});
}
