import 'package:flutter/material.dart';
import '../../core/base/base_view_model.dart';
import '../../core/models/NY_times_model.dart';

class HomeViewModel extends BaseViewModel {
  bool isInit = false;
  List<Result>? _items;

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
