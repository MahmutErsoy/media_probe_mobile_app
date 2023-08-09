import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:media_probe_mobile_app/service/post_service.dart';
import 'post_model.dart';

class ServiceGetView extends StatefulWidget {
  const ServiceGetView({super.key});

  @override
  State<ServiceGetView> createState() => _ServiceGetViewState();
}

class _ServiceGetViewState extends State<ServiceGetView> {
  List<PostModel>? _items;
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
    return Scaffold(
        appBar: AppBar(
          leading: const Icon(
            Icons.menu,
            size: 30,
          ),
          title: const Text("NY Times Most Popular"),
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
              ));
  }
}

class _PostCard extends StatelessWidget {
  const _PostCard({
    super.key,
    required PostModel? model,
  }) : _model = model;

  final PostModel? _model;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(
        bottom: 20,
      ),
      child: ListTile(
          onTap: () {},
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
