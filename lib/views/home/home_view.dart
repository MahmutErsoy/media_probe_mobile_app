import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_probe_mobile_app/core/components/global_widgets/bottom_bar.dart';
import 'package:provider/provider.dart';
import '../../core/base/base_view.dart';
import '../../core/models/NY_times_model.dart';
import '../../core/repository/ny_times_repository.dart';
import '../detail/detail_view.dart';
import '../favorite/favorite_view.dart';
import '../favorite/favorite_view_model.dart';
import 'home_view_model.dart';

part 'home_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Result>? _items;

  late final PostService _postService;

  @override
  void initState() {
    super.initState();
    _postService = PostService();
    fetchPostItems();
  }

  Future<void> fetchPostItems() async {
    final response = await _postService.fetchPostItems();

    if (response != null) {
      setState(() {
        _items = response;
        _sortItemsByDate();
      });
    }
  }

  void _sortItemsByDate() {
    if (_items != null) {
      _items!.sort((a, b) {
        return b.publishedDate!.compareTo(a.publishedDate!);
      });
    }
  }

  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomeView(),
    FavoriteView(),
  ];

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
      viewModel: Provider.of<HomeViewModel>(context, listen: false),
      onModelReady: (model) async {
        model.setContext(context);
        await model.init();
      },
      pageBuilder: (context, viewModel, _) => Scaffold(
          appBar: HomeAppBar(viewModel: viewModel),
          bottomNavigationBar: CustomBottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          backgroundColor: Colors.white,
          body: _items == null
              ? const Placeholder()
              : _currentIndex == 0
                  ? ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      itemCount: _items?.length ?? 0,
                      itemBuilder: (context, index) {
                        return PostCard(
                          model: _items?[index],
                          addToFavorites: addToFavorites,
                        );
                      },
                    )
                  : _pages[_currentIndex]),
    );
  }

  void addToFavorites(Result item) {
    final favoriteModel = Provider.of<FavoriteModel>(context, listen: false);

    if (!favoriteModel.favoriteItems.contains(item)) {
      favoriteModel.addToFavorites(item);
    } else {
      favoriteModel.removeFromFavorites(item);
    }
  }
}
