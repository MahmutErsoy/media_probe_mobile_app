import 'package:flutter/material.dart';
import '../../core/base/base_view_model.dart';
import '../../core/models/NY_times_model.dart';
import '../../core/repository/ny_times_repository.dart';
import '../favorite/favorite_view.dart';
import 'home_view.dart';

class HomeViewModel extends BaseViewModel {
  bool isInit = false;
  List<Result>? items;

  late final PostService _postService;

  String searchQuery = '';
  List<Result> filteredItems = [];

  int currentIndex = 0;

  final List<Widget> pages = [
    const HomeView(),
    const FavoriteView(),
  ];

  @override
  void setContext(BuildContext context) => this.context = context;

  @override
  Future<void> init() async {
    if (!isInit) {
      changeStatus();
      isInit = !isInit;
      _postService = PostService();
      fetchPostItems();
    }
  }

  Future<void> fetchPostItems() async {
    final response = await _postService.fetchPostItems();

    if (response != null) {
      items = response;
      _sortItemsByDate();
      notifyListeners();
    }
  }

  void _sortItemsByDate() {
    if (items != null) {
      items!.sort((a, b) {
        return b.publishedDate!.compareTo(a.publishedDate!);
      });
    }
  }

  void search(String query) {
    searchQuery = query;
    if (query.isEmpty) {
      filteredItems = List.from(items!); // Tüm öğeleri ekranda göster
    } else {
      filteredItems = items!.where((item) {
        return item.abstract!.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }
}

class MySearchController {
  final TextEditingController searchController = TextEditingController();
}
