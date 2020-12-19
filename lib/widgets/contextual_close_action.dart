import 'package:contextualactionbar/actions/action_mode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/items_controller.dart';
import '../typedef/handle_items.dart';

class ContextualCloseAction<T> extends StatelessWidget {
  final HandleItems<T> itemsHandler;
  final IconData closeIcon;
  const ContextualCloseAction(
      {Key key, this.itemsHandler, this.closeIcon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<ItemsController<T>>(
      builder: (BuildContext context, ItemsController<T> value, Widget child) {
        return IconButton(
            icon: Icon(closeIcon ?? Icons.close),
            onPressed: () {
              if (itemsHandler != null) {
                itemsHandler(value.items);
              }
              ActionMode.disable<T>(context);
            });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(),
      ),
    );
  }
}
