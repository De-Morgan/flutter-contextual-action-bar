import 'package:contextualactionbar/contextualactionbar.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ItemsController', () {
    late ItemsController<int> controller;
    late int notifications;

    setUp(() {
      controller = ItemsController<int>();
      notifications = 0;
      controller.addListener(() => notifications++);
    });

    tearDown(() => controller.dispose());

    test('starts with action mode disabled and no items', () {
      expect(controller.actionModeEnable, isFalse);
      expect(controller.items, isEmpty);
    });

    test('enableActionMode adds the item and enables action mode', () {
      controller.enableActionMode(1);

      expect(controller.actionModeEnable, isTrue);
      expect(controller.items, [1]);
      expect(controller.isItemPresent(1), isTrue);
      expect(notifications, greaterThan(0));
    });

    test('addItem enables action mode and ignores duplicates', () {
      controller.addItem(1);
      controller.addItem(2);
      controller.addItem(1);

      expect(controller.actionModeEnable, isTrue);
      expect(controller.items, unorderedEquals([1, 2]));
    });

    test('toggleItem adds and removes items', () {
      controller.enableActionMode(1);
      controller.toggleItem(2);
      expect(controller.items, unorderedEquals([1, 2]));

      controller.toggleItem(1);
      expect(controller.items, [2]);
      expect(controller.actionModeEnable, isTrue);
    });

    test('toggling off the last item disables action mode', () {
      controller.enableActionMode(1);
      controller.toggleItem(1);

      expect(controller.items, isEmpty);
      expect(controller.actionModeEnable, isFalse);
    });

    test('disableActionMode clears the selection', () {
      controller.addItem(1);
      controller.addItem(2);
      controller.disableActionMode();

      expect(controller.actionModeEnable, isFalse);
      expect(controller.items, isEmpty);
      expect(controller.isItemPresent(1), isFalse);
    });

    test('emptySelection clears items without changing action mode', () {
      controller.addItem(1);
      controller.emptySelection();

      expect(controller.items, isEmpty);
      expect(controller.actionModeEnable, isTrue);
    });

    test('isActionModeEnabled emits on every action mode change', () async {
      final emitted = <bool>[];
      final subscription = controller.isActionModeEnabled.listen(emitted.add);

      controller.enableActionMode(1);
      controller.disableActionMode();
      await Future<void>.delayed(Duration.zero);

      expect(emitted, [true, false]);
      await subscription.cancel();
    });
  });
}
