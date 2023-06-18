part of widgets;

class ContextualAction<T> extends StatelessWidget {
  final Widget child;
  final HandleItems<T> itemsHandler;

  const ContextualAction(
      {Key? key, required this.itemsHandler, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemsController<T>>(
      builder: (BuildContext context, ItemsController<T> value, Widget? child) {
        return InkWell(
          onTap: () {
            itemsHandler(value.items);
            ActionMode.disable<T>(context);
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
