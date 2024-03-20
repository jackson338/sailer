// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supply_stop.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupplyStop _$SupplyStopFromJson(Map<String, dynamic> json) => SupplyStop(
      title: json['Title'] as String,
      arrived: json['Arrived'] as bool,
      id: json['Id'] as String,
    );

Map<String, dynamic> _$SupplyStopToJson(SupplyStop instance) =>
    <String, dynamic>{
      'Title': instance.title,
      'Arrived': instance.arrived,
      'Id': instance.id,
    };
