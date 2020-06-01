import 'package:contextualactionbar/actions/action_mode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/items_controller.dart';
import '../typedef/handle_items.dart';

class ContextualAction<T> extends StatelessWidget {
  final Widget child;
  final HandleItems<T> itemsHandler;
  const ContextualAction(
      {Key key, @required this.itemsHandler, @required this.child})
      : assert(child != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<ItemsController<T>>(
      builder: (BuildContext context, ItemsController<T> value, Widget child) {
        return InkWell(
          onTap: () {
            itemsHandler(value.items);
            ActionMode.disableActionMode<T>(context);
          },
          child: child,
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: child,
      ),
    );
  }
}
