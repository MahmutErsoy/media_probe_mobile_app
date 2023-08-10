import 'package:flutter/material.dart';

import '../../core/models/NY_times_model.dart';
import '../detail/detail_view.dart';

class PostCard extends StatelessWidget {
  const PostCard({
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
