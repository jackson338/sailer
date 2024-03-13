import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sailer/models/destination_model.dart';
import 'package:sailer/models/supply_stop.dart';
part 'parent_state.dart';

class ParentCubit extends Cubit<ParentState> {
  ParentCubit() : super(const ParentState()) {
    sortSupplies();
  }

  void sortSupplies() {
    Map<String, List<SupplyStop>> supplyStops = {};
    state.supplyStops.forEach((key, value) {
      List<SupplyStop> sortedList = List.from(value)
        ..sort((a, b) {
          if (a.arrived == true && b.arrived == false) {
            return 1; // b comes before a
          } else if (a.arrived == false && b.arrived == true) {
            return -1; // a comes before b
          }
          return 0; // No change in order
        });
      supplyStops[key] = sortedList;
    });
    emit(state.copyWith(supplyStops: supplyStops));
  }

  void addDestination(String newDest) {
    Map<String, List<DestinationModel>> destinations = {
      ...state.destinations,
      newDest: [],
    };
    emit(state.copyWith(destinations: destinations));
  }

  void addSubDestination(String key, String subDest) {}
  void addSupplyStop(String key, String supplyStop) {}

  void toggleView() => emit(state.copyWith(view: !state.view));

  void arriveSupplyStop({
    required String destinationKey,
    required int supplyIndex,
    required bool arrive,
  }) {
    List<SupplyStop> newSupply = [...state.supplyStops[destinationKey]!];
    final replaceSupply = SupplyStop(
      title: newSupply[supplyIndex].title,
      arrived: arrive,
      id: DateTime.now().toString(),
    );
    newSupply.removeAt(supplyIndex);
    newSupply.insert(supplyIndex, replaceSupply);

    Map<String, List<SupplyStop>> supplyStops = {...state.supplyStops};
    supplyStops.update(destinationKey, (value) => newSupply);

    emit(state.copyWith(supplyStops: supplyStops));
    sortSupplies();
  }

  void arriveDestination({
    required String destinationKey,
    required int index,
    required bool arrive,
  }) {
    List<DestinationModel> destinations = [...state.destinations[destinationKey]!];
    final replaceSupply = DestinationModel(
      title: destinations[index].title,
      arrived: arrive,
      id: destinations[index].id,
    );
    destinations.removeAt(index);
    destinations.insert(index, replaceSupply);

    Map<String, List<DestinationModel>> newDestinations = {...state.destinations};
    newDestinations.update(destinationKey, (value) => destinations);

    emit(state.copyWith(destinations: newDestinations));
  }
}
