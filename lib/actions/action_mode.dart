part of contextualactionbar;

class ActionMode {
  ///Add an item of type T to the action mode
  static void addItem<T>(BuildContext context, T item) {
    final itemController =
        Provider.of<ItemsController<T>>(context, listen: false);
    itemController.addItem(item);
  }

  ///Add a list items of type T to the action mode
  static void addItems<T>(BuildContext context, List<T> items) {
    final itemController =
        Provider.of<ItemsController<T>>(context, listen: false);
    items.forEach((item) => itemController.addItem(item));
  }

  ///disable the action mode, this automatically deselect all selected items
  static void disable<T>(BuildContext context) {
    Provider.of<ItemsController<T>>(context, listen: false).disableActionMode();
  }

  /// This steam emits true or false depending on if the Action mode is enabled or disabled respectively
  static Stream<bool> enabledStream<T>(BuildContext context) {
    return Provider.of<ItemsController<T>>(context, listen: false)
        .isActionModeEnabled;
  }
}
