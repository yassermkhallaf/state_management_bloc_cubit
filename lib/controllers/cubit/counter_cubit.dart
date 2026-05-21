import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';
import '';

part 'counter_state.dart';

class CounterCubit extends HydratedCubit<CounterState> {
  CounterCubit() : super( const CounterState(countA: 0, countB: 0));

  void incrementA() {
    emit(state.copyWith(countA: state.countA + 1));
  }

  void decrementA() {
    emit(state.copyWith(countA: state.countA - 1));
  }

  void incrementB() {
    emit(state.copyWith( countB: state.countB + 1));
  }

  void decrementB() {
    emit(state.copyWith( countB: state.countB - 1));
  }

  @override
  CounterState? fromJson(Map<String, dynamic> json) {
    return CounterState(countA: json["countA"], countB: json["countB"]);
  }

  @override
  Map<String, dynamic>? toJson(CounterState state) {
    return {"countA": state.countA, "countB": state.countB};
  }
}
