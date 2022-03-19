// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Todo _$$_TodoFromJson(Map<String, dynamic> json) => _$_Todo(
      id: json['id'] as String,
      userId: json['userId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      isComplete: json['isComplete'] as bool? ?? false,
    );

Map<String, dynamic> _$$_TodoToJson(_$_Todo instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'title': instance.title,
      'description': instance.description,
      'isComplete': instance.isComplete,
    };
