import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/base/base_view.dart';
import '../../core/models/NY_times_model.dart';
import '../../core/repository/ny_times_repository.dart';
import 'home_view_model.dart';
import 'home_widget.dart';

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

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
      viewModel: Provider.of<HomeViewModel>(context, listen: false),
      onModelReady: (model) async {
        model.setContext(context);
        await model.init();
      },
      pageBuilder: (context, viewModel, _) => Scaffold(
          appBar: AppBar(
            leading: const Icon(
              Icons.menu,
              size: 30,
            ),
            title: Text(
              "NY Times Most Popular",
              style: Theme.of(context).textTheme.headline2,
            ),
            actions: const [
              Icon(
                Icons.search,
                size: 30,
              ),
              SizedBox(
                width: 20,
              ),
              Icon(
                Icons.more_vert,
                size: 30,
              ),
            ],
            backgroundColor: Colors.tealAccent[400],
          ),
          backgroundColor: Colors.white,
          body: _items == null
              ? const Placeholder()
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemCount: _items?.length ?? 0,
                  itemBuilder: (context, index) {
                    return PostCard(model: _items?[index]);
                  },
                )),
    );
  }
}
