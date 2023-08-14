import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/base/base_view.dart';
import '../../core/components/global_widgets/app_bar.dart';
import '../../core/models/NY_times_model.dart';
import 'detail_view_model.dart';

class DetailView extends StatelessWidget {
  const DetailView({Key? key, required this.model}) : super(key: key);

  final Result model;

  @override
  Widget build(BuildContext context) {
    return BaseView<DetailViewModel>(
      viewModel: Provider.of<DetailViewModel>(context, listen: false),
      onModelReady: (model) async {
        model.setContext(context);
        await model.init();
      },
      pageBuilder: (context, viewModel, _) => Scaffold(
        appBar: CustomAppBar(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.title ?? '',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "By: ${model.byline ?? 'Unknown'}",
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Published Date: ${model.publishedDate ?? ''}",
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              if (model.media != null && model.media!.isNotEmpty)
                Center(
                  child: Image.network(
                    model.media![0].mediaMetadata?[0].url ?? 'şş',
                    height: 150,
                    width: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              const SizedBox(height: 20),
              Text(
                model.abstract ?? '',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
