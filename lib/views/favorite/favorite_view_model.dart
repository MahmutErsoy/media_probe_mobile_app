import 'package:flutter/material.dart';
import '../../core/base/base_view_model.dart';

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
