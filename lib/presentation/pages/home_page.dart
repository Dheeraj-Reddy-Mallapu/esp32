import 'package:esp32/data/logic/led_state_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ledState = ref.watch(ledStateProvider);
    final ledStateNotifier = ref.read(ledStateProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                ledState == 0
                    ? Icons.lock_outline_rounded
                    : Icons.lock_open_rounded,
                color: ledState == 0 ? Colors.blueGrey : Colors.amber,
                size: 120,
              ),
              FilledButton(
                onPressed: () => ledStateNotifier.updateLedState(1 - ledState),
                child: Text(ledState != 0 ? 'Lock' : 'Unlock'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
