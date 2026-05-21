import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

part 'counter_state.dart';

class CounterCubit extends HydratedCubit<int> {
  CounterCubit() : super(0);

  void increment() {
    emit(state + 1);
  }

  void decrement() {
    emit(state - 1);
  }

  @override
  int? fromJson(Map<String, dynamic> json) {
    return json["count"];
  }

  @override
  Map<String, dynamic>? toJson(int state) {
    return {"count": state};
  }
}
