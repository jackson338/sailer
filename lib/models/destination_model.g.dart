// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'destination_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DestinationModel _$DestinationModelFromJson(Map<String, dynamic> json) =>
    DestinationModel(
      title: json['Title'] as String,
      arrived: json['Arrived'] as bool,
      id: json['Id'] as String,
    );

Map<String, dynamic> _$DestinationModelToJson(DestinationModel instance) =>
    <String, dynamic>{
      'Title': instance.title,
      'Arrived': instance.arrived,
      'Id': instance.id,
    };
