import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/base/base_view.dart';
import 'favorite_view_model.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({
    Key? key,
  }) : super(key: key);

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<FavoriteViewModel>(
      viewModel: Provider.of<FavoriteViewModel>(context, listen: false),
      onModelReady: (model) async {
        model.setContext(context);
        await model.init();
      },
      pageBuilder: (context, viewModel, _) => Scaffold(
        body: Center(),
      ),
    );
  }
}
