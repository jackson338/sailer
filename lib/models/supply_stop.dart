// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
part 'supply_stop.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal, explicitToJson: true)
class SupplyStop {
  final String title;
  final String? description;
  final bool arrived;
  final String id;
  const SupplyStop({
    required this.title,
    this.description,
    required this.arrived,
    required this.id,
  });
  factory SupplyStop.fromJson(Map<String, dynamic> json) => _$SupplyStopFromJson(json);

  Map<String, dynamic> toJson() => _$SupplyStopToJson(this);
}
