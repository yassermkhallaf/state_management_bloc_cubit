part of 'counter_cubit.dart';

@immutable
// sealed class CounterState extends Equatable {
//   final int countA;
//   final int countB;
//   CounterState(this.countA,this.countB);
//   @override
//   // TODO: implement props
//   List<Object?> get props => [countA,countB];
// }
//
// final class CounterInitial extends CounterState {
//   CounterInitial():super(0,0);
// }
// final class CounterUpdate extends CounterState{
//   CounterUpdate(super.countA, super.countB);
//
// }

class CounterState {
  final int countA;
  final int countB;
  const CounterState({ required this.countA, required this.countB});

  CounterState copyWith({
    int? countA,
    int? countB,
  }) {
    return CounterState(
      countA: countA ?? this.countA,
      countB: countB ?? this.countB,
    );
  }
}
