part of 'parent_cubit.dart';

class ParentState extends Equatable {
  final Map<String, List<DestinationModel>> destinations;
  final Map<String, List<SupplyStop>> supplyStops;
  final bool view;
  final List<String> celestialGoals;

  const ParentState({
    this.destinations = const {
      '2027 Destination': [
        DestinationModel(
          title: 'Home on 1 acre of land',
          arrived: false,
          id: '1',
        ),
        DestinationModel(
          title: 'Married in the temple',
          arrived: true,
          id: '2',
        ),
        DestinationModel(
          title: 'Test Goal',
          arrived: false,
          id: '3',
        ),
      ],
      '2029 Destination': [
        DestinationModel(
          title: 'Own a company',
          arrived: false,
          id: '4',
        ),
        DestinationModel(
          title: 'Have 2 kids',
          arrived: true,
          id: '5',
        ),
        DestinationModel(
          title: 'Build The Steps',
          arrived: false,
          id: '6',
        ),
        DestinationModel(
          title: 'Create prototype of the Vlens',
          arrived: true,
          id: '7',
        ),
      ],
    },
    this.view = false,
    this.celestialGoals = const [
      'Return to the presense of God and reign with him in Eternal Glory',
      'Fulfilled my life mission',
      'Become the person I want to become',
      'Have a great marriage and great family',
    ],
    this.supplyStops = const {
      '2027 Destination': [
        SupplyStop(
          id: '1',
          title: 'Save up \$150k',
          arrived: false,
        ),
        SupplyStop(
          id: '2',
          title: 'Purchase investment Property',
          arrived: true,
        ),
        SupplyStop(
          id: '3',
          title: 'Sketch out dream home',
          arrived: false,
        ),
        SupplyStop(
          id: '4',
          title: 'Price out the steps using price/sqft',
          arrived: true,
        ),
      ],
      '2029 Destination': [
        SupplyStop(
          id: '5',
          title: 'Have a kid',
          arrived: false,
        ),
        SupplyStop(
          id: '6',
          title: 'Save up \$1,000,000',
          arrived: false,
        ),
        SupplyStop(
          id: '7',
          title: 'Start a company',
          arrived: false,
        ),
      ],
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

  @override
  List<Object?> get props => [
        destinations,
        view,
        supplyStops,
      ];
}
