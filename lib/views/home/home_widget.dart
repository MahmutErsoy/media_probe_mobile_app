part of 'home_view.dart';

class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
    required Result? model,
    required this.addToFavorites,
  }) : model = model;

  final Result? model;
  final Function(Result) addToFavorites;

  @override
  Widget build(BuildContext context) {
    final favoriteModel = Provider.of<FavoriteModel>(context);

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
              builder: (context) => DetailView(model: model!),
            ),
          );
        },
        leading: const CircleAvatar(
          backgroundColor: Colors.grey,
        ),
        title: Text(
          model?.abstract ?? 'aa',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Wrap(
            children: [
              Text(
                model?.byline ?? 'kim yazdi la bunu',
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
                    model?.publishedDate ?? 'aa',
                  ),
                ],
              ),
            ],
          ),
        ),
        trailing: IconButton(
          icon: Icon(
            favoriteModel.favoriteItems.contains(model) ? Icons.favorite : Icons.favorite_border,
            color: favoriteModel.favoriteItems.contains(model) ? Colors.red : null,
          ),
          onPressed: () {
            addToFavorites(model!);
          },
        ),
      ),
    );
  }
}

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
    required this.viewModel,
  });

  final HomeViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.tealAccent[400],
        title: Text(
          "NY Times Most Popular",
          style: Theme.of(context).textTheme.headline2,
        ),
        leading: const Icon(Icons.menu),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
            ),
            onPressed: () {},
          ),
          const Icon(
            Icons.more_vert,
          ),
        ]);
  }

  @override
  Size get preferredSize => Size.fromHeight(50.sp);
}
