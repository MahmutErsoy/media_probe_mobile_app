import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:media_probe_mobile_app/views/favorite/favorite_view_model.dart';
import 'package:media_probe_mobile_app/views/home/home_view.dart';
import 'package:provider/provider.dart';
import 'core/constants/app_constants.dart';
import 'core/extension/provider_manager.dart';
import 'core/extension/theme_provider.dart';

Future<void> main() async {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ...ProviderManager.instance.singleProvider,
        ChangeNotifierProvider(create: (context) => FavoriteModel()),
      ],
      child: ScreenUtilInit(
        designSize: Size(AppConstants.designSize.width, AppConstants.designSize.height),
        builder: (context, child) => ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
          builder: (context, _) {
            final themeProvider = Provider.of<ThemeProvider>(context);
            return MaterialApp(
              themeMode: themeProvider.themeMode,
              theme: MyThemes.lightTheme,
              darkTheme: MyThemes.darkTheme,
              debugShowCheckedModeBanner: false,
              home: const HomeView(),
            );
          },
        ),
      ),
    );
  }
}
