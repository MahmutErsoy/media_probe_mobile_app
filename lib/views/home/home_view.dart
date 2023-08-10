import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/base/base_view.dart';
import '../../core/models/NY_times_model.dart';
import '../../core/repository/NY_times_repository.dart';
import '../detail/detail_view.dart';
import 'home_view_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Result>? _items;
  late final Dio _dio;
  final _baseUrl = 'https://api.nytimes.com/svc/mostpopular/v2/viewed/7.json?api-key=';

  late final PostService _postService;

  @override
  void initState() {
    super.initState();
    _dio = Dio(BaseOptions(baseUrl: _baseUrl));
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
                    return _PostCard(model: _items?[index]);
                  },
                )),
    );
  }
}

class _PostCard extends StatelessWidget {
  const _PostCard({
    super.key,
    required Result? model,
  }) : _model = model;

  final Result? _model;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue[700],
      margin: const EdgeInsets.only(
        bottom: 20,
      ),
      child: ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailView(model: _model!),
              ),
            );
          },
          leading: const CircleAvatar(
            backgroundColor: Colors.grey,
          ),
          title: Text(
            _model?.abstract ?? 'aa',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Wrap(
              children: [
                Text(
                  _model?.byline ?? 'kim yazdi la bunu',
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    const Icon(Icons.date_range_outlined),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      _model?.publishedDate ?? 'aa',
                    ),
                  ],
                ),
              ],
            ),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios_outlined,
          )),
    );
  }
}
