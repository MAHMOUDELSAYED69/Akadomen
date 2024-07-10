import 'package:bloc/bloc.dart';

class CalcCubit extends Cubit<Map<String, int>> {
  CalcCubit() : super({});

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
