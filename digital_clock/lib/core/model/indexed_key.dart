import 'package:flutter/widgets.dart';

/// As we know GlobalKey is used to manage widgets
/// but what if we want to get widget element by id
/// in this case we can use this element
class GlobalKeyToId<K extends State<StatefulWidget>, E> {
  final int _id;
  final GlobalKey<K> _globalKey;
  final E _data;

  GlobalKeyToId(this._id, this._globalKey, this._data);

  int get id => _id;
  GlobalKey<K> get globalKey => _globalKey;
  E get data => _data;
}

/// This holds GlobalKeyToId list
/// when we need to find them by id
/// or delete them by id it will be used
class GlobalKeyToIdManager<K extends State<StatefulWidget>, E> {
  final List<GlobalKeyToId<K, E>> _list;

  GlobalKeyToIdManager(this._list);

  // factory GlobalKeyToIdManager.init() {
  //   List<GlobalKeyToId<K, E>> tempList = [];
  //   return GlobalKeyToIdManager(tempList);
  // }

  // gettters
  int get length => _list.length;
  List<GlobalKeyToId<K, E>> get list => _list;

  GlobalKeyToId<K, E> findById(int id) {
    for (GlobalKeyToId<K, E> item in _list) {
      if (item.id == id) return item;
    }
    print('--- [findById] GlobalKey with $id NOT FOUND');
    throw ('--- [findById] GlobalKey with $id NOT FOUND');
  }

    GlobalKeyToId<K, E> findByIdIgnore(int id) {
    for (GlobalKeyToId<K, E> item in _list) {
      if (item.id == id) return item;
    }
  }

  /// This is act as stack pop
  /// where find element by [id]
  /// end delete it from list and return result
  GlobalKeyToId<K, E> pop(int id) {
    for (int i = 0; i < _list.length; i++) {
      GlobalKeyToId<K, E> item = _list[i];
      if (item.id == id) {
        _list.removeAt(i);
        return item;
      }
    }
    print('--- [pop] GlobalKey with $id NOT FOUND');
    throw ('--- [pop] GlobalKey with $id NOT FOUND');
  }

  void add(GlobalKeyToId<K, E> item) {
    _list.add(item);
  }

  void clear() {
    _list.clear();
  }

  int getIndex(GlobalKeyToId<K, E> key) {
    for (int order = 0; order < _list.length; order++) {
      if (_list[order] == key) return order;
    }
    throw ('--- The Key not FOUND');
  }
}
