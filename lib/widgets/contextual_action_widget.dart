import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/items_controller.dart';
import '../actions/action_mode.dart';

class ContextualActionWidget<T> extends StatelessWidget {
  final T data;

  /// It is important that the child does not handle onLongPress
  final Widget child;

  /// The color for the child when selected
  final Color selectedColor;

  /// The widget to be displayed on top the child widget when selected
  final Widget selectedWidget;

  const ContextualActionWidget(
      {Key key,
      @required this.data,
      @required this.child,
      this.selectedWidget,
      this.selectedColor})
      : assert(data != null),
        assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemController = Provider.of<ItemsController<T>>(context);
    final bool isItemAdded = itemController.isItemPresent(data);
    return InkWell(
      onLongPress: () => itemController.enableActionMode(data),
      onTap: () => itemController.toggleItem(data),
      child: AbsorbPointer(
        absorbing: itemController.actionModeEnable,
        child: Stack(
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                    color: isItemAdded
                        ? selectedColor ?? Theme.of(context).splashColor
                        : Colors.transparent),
                child: child),
            if (isItemAdded && selectedWidget != null) selectedWidget
          ],
        ),
      ),
    );
  }
}
