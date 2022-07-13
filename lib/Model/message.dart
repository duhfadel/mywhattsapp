import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
part 'message.g.dart';

@JsonSerializable()
class Message {
  final String text;
  String? id;
  final String? to;
  final String? from;
  DateTime time;

  Message(
      {required this.text,
      required this.to,
      required this.from,
      this.id,
      required this.time});

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);

  factory Message.fromSnapshot(QueryDocumentSnapshot<Object?> snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Message.fromJson(data)..id = snapshot.id;
  }
}
