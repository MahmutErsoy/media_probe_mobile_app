import 'package:flutter/material.dart';
import 'package:media_probe_mobile_app/views/home/home_view.dart';
import 'package:provider/provider.dart';
import '../../core/base/base_view.dart';
import '../../core/base/base_view_model.dart';
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
    final favoriteModel = Provider.of<FavoriteModel>(context);

    return BaseView<FavoriteViewModel>(
      viewModel: Provider.of<FavoriteViewModel>(context, listen: false),
      onModelReady: (model) async {
        model.setContext(context);
        await model.init();
      },
      pageBuilder: (context, viewModel, _) => Scaffold(
          body: ListView.builder(
        itemCount: favoriteModel.favoriteItems.length,
        itemBuilder: (context, index) {
          return PostCard(
            model: favoriteModel.favoriteItems[index],
            addToFavorites: (item) {
              viewModel.addToFavorites(item);
            },
          );
        },
      )),
    );
  }
}
