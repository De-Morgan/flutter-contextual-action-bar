import 'package:contextualactionbar/contextualactionbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

const _items = ['Apple', 'Banana', 'Cherry'];

/// In action mode the item's child absorbs pointers, so taps must target the
/// [ContextualActionWidget] itself rather than the text inside it.
Finder _item(String text) =>
    find.widgetWithText(ContextualActionWidget<String>, text);

Widget _buildApp({
  void Function(List<String> items)? onDelete,
  ValueChanged<BuildContext>? onBodyContext,
}) {
  return MaterialApp(
    home: ContextualScaffold<String>(
      appBar: AppBar(title: const Text('Fruits')),
      contextualAppBar: ContextualAppBar<String>(
        counterBuilder: (count) => Text('$count selected'),
        contextualActions: [
          ContextualAction<String>(
            itemsHandler: (items) => onDelete?.call(items),
            child: const Icon(Icons.delete),
          ),
        ],
      ),
      body: Builder(
        builder: (context) {
          onBodyContext?.call(context);
          return ListView(
            children: [
              for (final item in _items)
                ContextualActionWidget<String>(
                  data: item,
                  selectedWidget: const Icon(Icons.check_box),
                  unselectedWidget: const Icon(Icons.check_box_outline_blank),
                  child: ListTile(title: Text(item)),
                ),
            ],
          );
        },
      ),
    ),
  );
}

void main() {
  testWidgets('shows the normal app bar until an item is long pressed',
      (tester) async {
    await tester.pumpWidget(_buildApp());

    expect(find.text('Fruits'), findsOneWidget);
    expect(find.byIcon(Icons.close), findsNothing);
    expect(find.byIcon(Icons.delete), findsNothing);

    await tester.longPress(_item('Apple'));
    await tester.pump();

    expect(find.text('1 selected'), findsOneWidget);
    expect(find.byIcon(Icons.close), findsOneWidget);
    expect(find.byIcon(Icons.delete), findsOneWidget);
  });

  testWidgets('shows selected and unselected widgets in action mode',
      (tester) async {
    await tester.pumpWidget(_buildApp());

    expect(find.byIcon(Icons.check_box), findsNothing);
    expect(find.byIcon(Icons.check_box_outline_blank), findsNothing);

    await tester.longPress(_item('Apple'));
    await tester.pump();

    expect(find.byIcon(Icons.check_box), findsOneWidget);
    expect(find.byIcon(Icons.check_box_outline_blank), findsNWidgets(2));
  });

  testWidgets('tapping items in action mode toggles their selection',
      (tester) async {
    await tester.pumpWidget(_buildApp());

    await tester.longPress(_item('Apple'));
    await tester.pump();
    await tester.tap(_item('Banana'));
    await tester.pump();
    expect(find.text('2 selected'), findsOneWidget);

    await tester.tap(_item('Banana'));
    await tester.pump();
    expect(find.text('1 selected'), findsOneWidget);
  });

  testWidgets('deselecting the last item leaves action mode', (tester) async {
    await tester.pumpWidget(_buildApp());

    await tester.longPress(_item('Apple'));
    await tester.pump();
    await tester.tap(_item('Apple'));
    await tester.pump();

    expect(find.byIcon(Icons.close), findsNothing);
    expect(find.text('Fruits'), findsOneWidget);
  });

  testWidgets('close button leaves action mode and clears the selection',
      (tester) async {
    await tester.pumpWidget(_buildApp());

    await tester.longPress(_item('Apple'));
    await tester.pump();
    await tester.tap(find.byIcon(Icons.close));
    await tester.pump();

    expect(find.byIcon(Icons.close), findsNothing);
    expect(find.byIcon(Icons.check_box), findsNothing);

    await tester.longPress(_item('Banana'));
    await tester.pump();
    expect(find.text('1 selected'), findsOneWidget);
  });

  testWidgets('contextual action receives the selected items', (tester) async {
    List<String>? handled;
    await tester.pumpWidget(_buildApp(onDelete: (items) => handled = items));

    await tester.longPress(_item('Apple'));
    await tester.pump();
    await tester.tap(_item('Cherry'));
    await tester.pump();
    await tester.tap(find.byIcon(Icons.delete));
    await tester.pump();

    expect(handled, unorderedEquals(['Apple', 'Cherry']));
    expect(find.byIcon(Icons.close), findsNothing);
  });

  testWidgets('ActionMode adds items, reports state and disables',
      (tester) async {
    late BuildContext bodyContext;
    await tester.pumpWidget(_buildApp(onBodyContext: (c) => bodyContext = c));

    final emitted = <bool>[];
    final subscription =
        ActionMode.enabledStream<String>(bodyContext).listen(emitted.add);
    addTearDown(subscription.cancel);

    ActionMode.addItems<String>(bodyContext, ['Apple', 'Banana']);
    await tester.pump();
    expect(find.text('2 selected'), findsOneWidget);

    ActionMode.addItem<String>(bodyContext, 'Cherry');
    await tester.pump();
    expect(find.text('3 selected'), findsOneWidget);

    ActionMode.disable<String>(bodyContext);
    await tester.pump();
    expect(find.byIcon(Icons.close), findsNothing);

    expect(emitted, [true, false]);
  });
}
