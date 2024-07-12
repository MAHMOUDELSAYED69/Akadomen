import 'package:bloc/bloc.dart';
import 'package:akadomen/models/juice.dart';

class CalculatorCubit extends Cubit<Map<JuiceModel, int>> {
  CalculatorCubit() : super({});

  void increment(JuiceModel juice) {
    final currentCount = state[juice] ?? 0;
    emit({...state, juice: currentCount + 1});
  }

  void decrement(JuiceModel juice) {
    final currentCount = state[juice] ?? 0;
    if (currentCount > 0) {
      emit({...state, juice: currentCount - 1});
    }
  }

  void reset() => emit({});

  double getTotalPrice() {
    return state.entries.fold<double>(0, (sum, entry) {
      return sum + entry.key.price * entry.value;
    });
  }
}
