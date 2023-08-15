import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_probe_mobile_app/core/components/global_widgets/bottom_bar.dart';
import 'package:provider/provider.dart';
import '../../core/base/base_view.dart';
import '../../core/base/base_view_model.dart';
import '../../core/models/NY_times_model.dart';
import '../detail/detail_view.dart';
import 'home_view_model.dart';

part 'home_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final MySearchController mySearchController = MySearchController();

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
      viewModel: Provider.of<HomeViewModel>(context, listen: false),
      onModelReady: (model) async {
        model.setContext(context);
        await model.init();
      },
      pageBuilder: (context, viewModel, _) => Scaffold(
          appBar: HomeAppBar(
            viewModel: viewModel,
            mySearchController: mySearchController,
          ),
          bottomNavigationBar: CustomBottomNavigationBar(
            currentIndex: viewModel.currentIndex,
            onTap: (index) {
              setState(() {
                viewModel.currentIndex = index;
              });
            },
          ),
          backgroundColor: Colors.white,
          body: viewModel.items == null
              ? const Center(child: CircularProgressIndicator())
              : viewModel.currentIndex == 0 && !viewModel.searchQuery.isNotEmpty
                  ? ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      itemCount: viewModel.items?.length ?? 0,
                      itemBuilder: (context, index) {
                        return PostCard(
                          model: viewModel.items?[index],
                          addToFavorites: viewModel.addToFavorites,
                        );
                      },
                    )
                  : (viewModel.searchQuery.isNotEmpty)
                      ? Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount: viewModel.filteredItems.length,
                                itemBuilder: (context, index) {
                                  return PostCard(
                                    model: viewModel.filteredItems[index],
                                    addToFavorites: viewModel.addToFavorites,
                                  );
                                },
                              ),
                            ),
                          ],
                        )
                      : viewModel.pages[viewModel.currentIndex]

          //: viewModel.pages[viewModel.currentIndex]
          ),
    );
  }
}
