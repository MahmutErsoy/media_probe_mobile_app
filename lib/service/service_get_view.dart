import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'post_model.dart';

class ServiceGetView extends StatefulWidget {
  const ServiceGetView({super.key});

  @override
  State<ServiceGetView> createState() => _ServiceGetViewState();
}

class _ServiceGetViewState extends State<ServiceGetView> {
  List<PostModel>? _items;

  @override
  void initState() {
    super.initState();
    fetchPostItems();
  }

  Future<void> fetchPostItems() async {
    final response = await Dio()
        .get('https://api.nytimes.com/svc/mostpopular/v2/viewed/7.json?api-key=i5U0k05a2ZwXJKoID0P5zLeKxkEvkpBG');

    if (response.statusCode == HttpStatus.ok) {
      final _datas = response.data;

      if (_datas.containsKey('results')) {
        final results = _datas['results'];

        setState(() {
          _items = results.map((e) => PostModel.fromJson(e)).toList();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.black,
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemCount: _items?.length ?? 0,
        itemBuilder: (context, index) {
          return _PostCard(model: _items?[index]);
        },
      ),
    );
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
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        title: Text(_model?.title ?? 'aa'),
        subtitle: Text(_model?.abstract ?? 'aa'),
      ),
    );
  }
}
