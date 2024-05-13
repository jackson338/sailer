// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
part 'destination_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal, explicitToJson: true)
class DestinationModel {
  final String title;
  final bool arrived;
  final String id;
  const DestinationModel({
    required this.title,
    required this.arrived,
    required this.id,
  });
  factory DestinationModel.fromJson(Map<String, dynamic> json) =>
      _$DestinationModelFromJson(json);

  Map<String, dynamic> toJson() => _$DestinationModelToJson(this);
}
