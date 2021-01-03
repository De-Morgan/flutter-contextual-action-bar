import 'dart:async';

import 'package:flutter/foundation.dart';

class ItemsController<T> extends ChangeNotifier {
  final Set<T> _items = {};
  bool _actionModeEnabled = false;

  bool get actionModeEnable => _actionModeEnabled;

  List<T> get items => _items.toList();

  final bool allowZeroItems;
  
  ItemsController({this.allowZeroItems = false});

  bool isItemPresent(T item) => _items.contains(item);
  StreamController<bool> _isActionModeEnableController =
      StreamController.broadcast();

  StreamSink<bool> get _isActionModeEnableSink =>
      _isActionModeEnableController.sink;

  Stream<bool> get isActionModeEnabled => _isActionModeEnableController.stream;

  void emptySelection() {
    _items.clear();
  }

  void _modifyActionMode(bool value) {
    _actionModeEnabled = value;
    _isActionModeEnableSink.add(actionModeEnable);
    notifyListeners();
  }

  void enableActionMode(T item) {
    _items.add(item);
    _modifyActionMode(true);
  }

  void enableActionModeList(Iterable<T> items) {
    _items.addAll(items);
    _modifyActionMode(true);
  }

  void enableActionModeZeroItems() {
    if (allowZeroItems) {
      _modifyActionMode(true);
    }
  }

  void disableActionMode() {
    _modifyActionMode(false);
    emptySelection();
  }

  void addItem(T item) {
    _items.add(item);
    if (!_actionModeEnabled) {
      _modifyActionMode(true);
    }
    notifyListeners();
  }

  void toggleItem(T item) {
    if (_items.contains(item)) {
      _items.remove(item);
    } else {
      _items.add(item);
    }
    if (!_actionModeEnabled) {
      _modifyActionMode(true);
    }
    if (_items.isEmpty && !allowZeroItems) {
      disableActionMode();
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _isActionModeEnableController.close();
    _isActionModeEnableSink.close();
    super.dispose();
  }
}
