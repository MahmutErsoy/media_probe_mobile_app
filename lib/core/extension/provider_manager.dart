import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../../views/detail/detail_view_model.dart';
import '../../views/favorite/favorite_view_model.dart';
import '../../views/home/home_view_model.dart';

class ProviderManager {
  static ProviderManager? _instance;
  static ProviderManager get instance {
    _instance ??= ProviderManager._init();
    return _instance!;
  }

  ProviderManager._init();
  List<SingleChildWidget> singleProvider = [
    ChangeNotifierProvider<HomeViewModel>(
      create: (_) => HomeViewModel(),
    ),
    ChangeNotifierProvider<DetailViewModel>(
      create: (_) => DetailViewModel(),
    ),
    ChangeNotifierProvider<FavoriteViewModel>(
      create: (_) => FavoriteViewModel(),
    ),
  ];
}
