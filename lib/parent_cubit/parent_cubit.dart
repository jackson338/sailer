import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:sailer/models/destination_model.dart';
import 'package:sailer/models/supply_stop.dart';
import 'package:sailer/parent_cubit/parent_state.dart';

class ParentCubit extends HydratedCubit<ParentState> {
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
    Map<String, List<SupplyStop>> supplyStops = {
      ...state.supplyStops,
      newDest: [],
    };
    emit(state.copyWith(destinations: destinations, supplyStops: supplyStops));
  }

  void addSubDestination(String key, String subDest) {
    List<DestinationModel> sd = [];
    if (state.destinations[key] != null) {
      sd = [...state.destinations[key]!];
    }
    sd.add(
      DestinationModel(
        title: subDest,
        arrived: false,
        id: DateTime.now().toString(),
      ),
    );
    Map<String, List<DestinationModel>> destinations = {
      ...state.destinations.map(
        (k, value) => k == key ? MapEntry(key, sd) : MapEntry(k, value),
      )
    };

    emit(state.copyWith(destinations: destinations));
  }

  void addSupplyStop(String key, String supplyStop) {
    List<SupplyStop> sp = [];
    if (state.supplyStops[key] != null) {
      sp = [...state.supplyStops[key]!];
    }
    sp.add(
      SupplyStop(
        title: supplyStop,
        arrived: false,
        id: DateTime.now().toString(),
      ),
    );
    Map<String, List<SupplyStop>> supplyStops = {
      ...state.supplyStops.map(
        (k, value) => k == key ? MapEntry(key, sp) : MapEntry(k, value),
      )
    };

    emit(state.copyWith(supplyStops: supplyStops));
  }

  void removeDestination(String key) {
    Map<String, List<DestinationModel>> destinations = {
      ...state.destinations,
    };
    destinations.removeWhere((key, value) => key == key);
    Map<String, List<SupplyStop>> supplyStops = {
      ...state.supplyStops,
    };
    supplyStops.removeWhere((key, value) => key == key);
    emit(state.copyWith(destinations: destinations, supplyStops: supplyStops));
  }

  void removeSubDestination(String key, int index) {
    List<DestinationModel> sd = [];
    if (state.destinations[key] != null) {
      sd = [...state.destinations[key]!];
    }
    sd.removeAt(index);
    Map<String, List<DestinationModel>> destinations = {
      ...state.destinations.map(
        (k, value) => k == key ? MapEntry(key, sd) : MapEntry(k, value),
      )
    };

    emit(state.copyWith(destinations: destinations));
  }

  void removeSupply(
    String key,
    int index,
  ) {
    List<SupplyStop> sp = [];
    if (state.supplyStops[key] != null) {
      sp = [...state.supplyStops[key]!];
    }
    sp.removeAt(index);
    Map<String, List<SupplyStop>> supplyStops = {
      ...state.supplyStops.map(
        (k, value) => k == key ? MapEntry(key, sp) : MapEntry(k, value),
      )
    };
    emit(state.copyWith(supplyStops: supplyStops));
  }

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

  @override
  ParentState? fromJson(Map<String, dynamic> json) {
    return ParentState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(ParentState state) {
    return state.toJson();
  }
}
