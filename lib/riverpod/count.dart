import 'package:flutter_riverpod/flutter_riverpod.dart';

class CounterState extends StateNotifier<int> {
  CounterState() : super(0);

  void increment() {
    state++;
  }

  void multipleir() => state = state * 2;

  void decrement(int numer) => state -= numer;
}

final countProvider = StateNotifierProvider<CounterState, int>((ref) {
  return CounterState();
});
