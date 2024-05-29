// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_goal_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubGoalModel _$SubGoalModelFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['YearGoal'],
  );
  return SubGoalModel(
    yearGoal:
        DestinationModel.fromJson(json['YearGoal'] as Map<String, dynamic>),
    subGoal: SupplyStop.fromJson(json['SubGoal'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SubGoalModelToJson(SubGoalModel instance) =>
    <String, dynamic>{
      'YearGoal': instance.yearGoal,
      'SubGoal': instance.subGoal,
    };
