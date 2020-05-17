import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/items_controller.dart';

class ActionMode {
  static void addItem<T>(BuildContext context, T item) {
    final itemController =
        Provider.of<ItemsController<T>>(context, listen: false);
    itemController.addItem(item);
  }
}
