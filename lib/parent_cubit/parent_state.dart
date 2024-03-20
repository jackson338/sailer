// ignore: depend_on_referenced_packages
import 'package:equatable/equatable.dart';
// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
import 'package:sailer/models/destination_model.dart';
import 'package:sailer/models/supply_stop.dart';
part 'parent_state.g.dart';

@JsonSerializable(fieldRename: FieldRename.pascal, explicitToJson: true)
class ParentState extends Equatable {
  final Map<String, List<DestinationModel>> destinations;
  final Map<String, List<SupplyStop>> supplyStops;
  final bool view;
  final List<String> celestialGoals;

  const ParentState({
    this.destinations = const {
      '2024 Destination': [],
    },
    this.view = false,
    this.celestialGoals = const [
      'Return to the presense of God and reign with him in Eternal Glory in the Celestial Kingdom',
      'Faithful Temple Marriage',
      'Become the person I need to become',
      'Fulfilled my life mission',
      'Have a great marriage and great family',
    ],
    this.supplyStops = const {
      '2024 Destination': [],
    },
  });

  ParentState copyWith({
    final Map<String, List<DestinationModel>>? destinations,
    final bool? view,
    final Map<String, List<SupplyStop>>? supplyStops,
  }) {
    return ParentState(
      destinations: destinations ?? this.destinations,
      view: view ?? this.view,
      supplyStops: supplyStops ?? this.supplyStops,
    );
  }

  factory ParentState.fromJson(Map<String, dynamic> json) => _$ParentStateFromJson(json);

  Map<String, dynamic> toJson() => _$ParentStateToJson(this);

  @override
  List<Object?> get props => [
        destinations,
        view,
        supplyStops,
      ];
}
