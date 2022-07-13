// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      text: json['text'] as String,
      to: json['to'] as String,
      from: json['from'] as String,
      id: json['id'] as String?,
      time: DateTime.parse(json['time'] as String),
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'text': instance.text,
      'id': instance.id,
      'to': instance.to,
      'from': instance.from,
      'time': instance.time.toIso8601String(),
    };
