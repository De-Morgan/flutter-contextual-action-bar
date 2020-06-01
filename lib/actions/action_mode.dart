import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/items_controller.dart';

class ActionMode {
  static void addItem<T>(BuildContext context, T item) {
    final itemController =
        Provider.of<ItemsController<T>>(context, listen: false);
    itemController.addItem(item);
  }

  static void addAll<T>(BuildContext context, List<T> items) {
    final itemController =
        Provider.of<ItemsController<T>>(context, listen: false);
    items.forEach((item) => itemController.addItem(item));
  }

  static void disableActionMode<T>(
    BuildContext context,
  ) {
    Provider.of<ItemsController<T>>(context, listen: false).disableActionMode();
  }
}
