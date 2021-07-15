import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controller/items_controller.dart';
import 'widgets/contextual_action_bar.dart';

class ContextualScaffold<T> extends StatelessWidget {
  final bool extendBody;

  final bool extendBodyBehindAppBar;

  final PreferredSizeWidget? appBar;
  final ContextualAppBar<T> contextualAppBar;

  final Widget? body;

  final Widget? floatingActionButton;

  final FloatingActionButtonLocation? floatingActionButtonLocation;

  final FloatingActionButtonAnimator? floatingActionButtonAnimator;

  final List<Widget>? persistentFooterButtons;

  final Widget? drawer;

  final Widget? endDrawer;

  final Color? drawerScrimColor;

  final Color? backgroundColor;

  final Widget? bottomNavigationBar;

  final Widget? bottomSheet;

  final bool? resizeToAvoidBottomInset;

  final bool primary;
  final double? drawerEdgeDragWidth;
  final DragStartBehavior drawerDragStartBehavior;

  const ContextualScaffold({
    Key? key,
    this.appBar,
    required this.contextualAppBar,
    this.body,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.drawer,
    this.endDrawer,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.backgroundColor,
    this.resizeToAvoidBottomInset,
    this.primary = true,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.drawerScrimColor,
    this.drawerEdgeDragWidth,
  })  : assert(primary != null),
        assert(extendBody != null),
        assert(contextualAppBar != null),
        assert(extendBodyBehindAppBar != null),
        assert(drawerDragStartBehavior != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ItemsController<T>>(
      create: (BuildContext context) => ItemsController<T>(),
      builder: (BuildContext context, Widget? child) {
        bool isActionModeEnable() =>
            Provider.of<ItemsController<T>>(context).actionModeEnable;
        return Stack(
          children: [
            Positioned.fill(
              child: Scaffold(
                appBar: appBar,
                body: child,
                floatingActionButton: floatingActionButton,
                floatingActionButtonLocation: floatingActionButtonLocation,
                floatingActionButtonAnimator: floatingActionButtonAnimator,
                persistentFooterButtons: persistentFooterButtons,
                drawer: drawer,
                endDrawer: endDrawer,
                bottomNavigationBar: bottomNavigationBar,
                bottomSheet: bottomSheet,
                backgroundColor: backgroundColor,
                resizeToAvoidBottomInset: resizeToAvoidBottomInset,
                primary: primary,
                drawerDragStartBehavior: drawerDragStartBehavior,
                extendBody: extendBody,
                extendBodyBehindAppBar: extendBody,
                drawerScrimColor: drawerScrimColor,
                drawerEdgeDragWidth: drawerEdgeDragWidth,
              ),
            ),
            if (isActionModeEnable())
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                child: contextualAppBar,
              ),
          ],
        );
      },
      child: body,
    );
  }
}
