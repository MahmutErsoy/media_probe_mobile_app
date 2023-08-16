// ignore_for_file: public_member_api_docs, sort_constructors_first
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
      color: Colors.blueAccent,
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
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CircleAvatar(
              backgroundImage: model?.media != null && model!.media!.isNotEmpty
                  ? NetworkImage(
                      model!.media![0].mediaMetadata?[0].url ?? '',
                    )
                  : null,
            ),
          ],
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
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              icon: Icon(
                favoriteModel.favoriteItems.contains(model) ? Icons.favorite : Icons.favorite_border,
                color: favoriteModel.favoriteItems.contains(model) ? Colors.red : null,
              ),
              onPressed: () {
                addToFavorites(model!);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
    required this.viewModel,
    required this.mySearchController,
  });

  final HomeViewModel viewModel;
  final MySearchController mySearchController;

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(50.sp);
}

class _HomeAppBarState extends State<HomeAppBar> {
  bool _isSearching = false;
  bool showCloseButton = false;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.tealAccent[400],
      title: _isSearching
          ? TextField(
              controller: widget.mySearchController.searchController,
              onChanged: (query) {
                widget.viewModel.search(query);
              },
              style: const TextStyle(color: Colors.black, fontSize: 20),
              decoration: const InputDecoration(
                hintText: "Search...",
                hintStyle: TextStyle(color: Colors.white),
                border: InputBorder.none,
              ),
            )
          : Text(
              "NY Times Most Popular",
              style: Theme.of(context).textTheme.headline2,
            ),
      leading: const Icon(
        Icons.menu,
        color: Colors.black,
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.search,
            color: Colors.black,
          ),
          onPressed: () {
            setState(() {
              _isSearching = !_isSearching;
              showCloseButton = _isSearching;
              if (!_isSearching) {
                widget.mySearchController.searchController.clear();
                widget.viewModel.search('');
              }
            });
          },
        ),
        if (_isSearching)
          IconButton(
              onPressed: () {
                setState(() {
                  _isSearching = false;
                  showCloseButton = false;
                  widget.mySearchController.searchController.clear();
                  widget.viewModel.search('');
                });
              },
              icon: const Icon(Icons.close)),
      ],
    );
  }
}
