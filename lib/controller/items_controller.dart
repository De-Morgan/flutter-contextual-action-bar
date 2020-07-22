import 'dart:async';

import 'package:flutter/cupertino.dart';

class ItemsController<T> extends ChangeNotifier {
  final Set<T> _items = {};
  bool _actionModeEnabled = false;
  bool get actionModeEnable => _actionModeEnabled;
  List<T> get items => _items.toList();
  bool isItemPresent(T item) => _items.contains(item);
  StreamController<bool> _isActionModeEnableController = StreamController.broadcast();
  StreamSink<bool> get _isActionModeEnableSink =>_isActionModeEnableController.sink;
  Stream<bool> get isActionModeEnabled => _isActionModeEnableController.stream;
  void emptySelection() {
    _items.clear();
  }

  void enableActionMode(T item) {
    _items.add(item);
    _actionModeEnabled = true;
    _isActionModeEnableSink.add(true);
    notifyListeners();
  }

  void disableActionMode() {
    _actionModeEnabled = false;
    _isActionModeEnableSink.add(false);
    emptySelection();
    notifyListeners();
  }

  void addItem(T item) {
    _items.add(item);
    notifyListeners();
  }

  void toggleItem(T item) {
    if (_items.contains(item)) {
      _items.remove(item);
    } else {
      _items.add(item);
    }

    if (!_actionModeEnabled) {
      _actionModeEnabled = true;
    }
    if (_items.isEmpty) {
      disableActionMode();
    }
    notifyListeners();
  }
}
