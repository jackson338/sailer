import 'package:equatable/equatable.dart';
import 'package:gemini_goals/models/destination_model.dart';
import 'package:gemini_goals/models/supply_stop.dart';
// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'sub_goal_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal)
class SubGoalModel extends Equatable {
  @JsonKey(required: true)
  final DestinationModel yearGoal;
  final SupplyStop subGoal;
  const SubGoalModel({
    required this.yearGoal,
    required this.subGoal,
  });

  factory SubGoalModel.fromJson(Map<String, dynamic> json) =>
      _$SubGoalModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubGoalModelToJson(this);

  @override
  List<Object?> get props => [
        yearGoal,
        subGoal,
      ];
}
