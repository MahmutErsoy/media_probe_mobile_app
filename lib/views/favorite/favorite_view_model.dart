import 'package:flutter/material.dart';

import '../../core/base/base_view_model.dart';
import '../../core/models/NY_times_model.dart';

class FavoriteViewModel extends BaseViewModel {
  bool isInit = false;

  @override
  void setContext(BuildContext context) => this.context = context;

  @override
  Future<void> init() async {
    if (!isInit) {
      changeStatus();
      isInit = !isInit;
    }
  }
}

class FavoriteModel extends ChangeNotifier {
  List<Result> favoriteItems = [];

  void addToFavorites(Result item) {
    if (!favoriteItems.contains(item)) {
      favoriteItems.add(item);
      notifyListeners();
    }
  }

  void removeFromFavorites(Result item) {
    if (favoriteItems.contains(item)) {
      favoriteItems.remove(item);
      notifyListeners();
    }
  }
}
