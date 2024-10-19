import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'led_state_provider.g.dart';

@riverpod
class LedState extends _$LedState {
  late final StreamSubscription<int> _streamSubscription;

  @override
  int build() {
    init();
    return 0;
  }

  Stream<int> _buildStream() {
    final databaseRef = FirebaseDatabase.instance.ref('led/state');
    return databaseRef.onValue.map((event) => event.snapshot.value as int);
  }

  init() {
    _streamSubscription = _buildStream().listen((newState) {
      state = newState;
    });
  }

  Future<void> updateLedState(int newState) async {
    state = newState;
    await FirebaseDatabase.instance.ref('led/state').set(newState);
  }

  void dispose() {
    _streamSubscription.cancel();
  }
}
