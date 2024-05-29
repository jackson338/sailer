// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParentState _$ParentStateFromJson(Map<String, dynamic> json) => ParentState(
      destinations: (json['Destinations'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(
                k,
                (e as List<dynamic>)
                    .map((e) =>
                        DestinationModel.fromJson(e as Map<String, dynamic>))
                    .toList()),
          ) ??
          const {'2024 Destination': []},
      view: json['View'] as bool? ?? false,
      celestialGoals: (json['CelestialGoals'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [
            'Return to the presense of God and reign with him in Eternal Glory in the Celestial Kingdom',
            'Faithful Temple Marriage',
            'Become the person I need to become',
            'Fulfilled my life mission',
            'Have a great marriage and great family'
          ],
      supplyStops: (json['SupplyStops'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(
                k,
                (e as List<dynamic>)
                    .map((e) => SupplyStop.fromJson(e as Map<String, dynamic>))
                    .toList()),
          ) ??
          const {'2024 Destination': []},
    );

Map<String, dynamic> _$ParentStateToJson(ParentState instance) =>
    <String, dynamic>{
      'Destinations': instance.destinations
          .map((k, e) => MapEntry(k, e.map((e) => e.toJson()).toList())),
      'SupplyStops': instance.supplyStops
          .map((k, e) => MapEntry(k, e.map((e) => e.toJson()).toList())),
      'View': instance.view,
      'CelestialGoals': instance.celestialGoals,
    };
