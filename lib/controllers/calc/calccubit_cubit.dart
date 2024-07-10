import 'package:bloc/bloc.dart';

class CounterCubit extends Cubit<Map<String, int>> {
  CounterCubit() : super({});

  void increment(String juiceType) {
    final currentCount = state[juiceType] ?? 0;
    emit({...state, juiceType: currentCount + 1});
  }

  void decrement(String juiceType) {
    final currentCount = state[juiceType] ?? 0;
    if (currentCount > 0) {
      emit({...state, juiceType: currentCount - 1});
    }
  }

  void reset() => emit({});
}

