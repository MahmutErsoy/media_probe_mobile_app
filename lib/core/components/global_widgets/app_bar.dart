import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/colors_constants.dart';
import '../../constants/string_constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(context) {
    return AppBar(
      backgroundColor: ColorConstants.instance.tealAccent,
      elevation: 0,
      centerTitle: true,
      toolbarHeight: 50.sp,
      leading: InkWell(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Icon(
          Icons.arrow_back,
          size: 40.h,
          color: ColorConstants.instance.white,
        ),
      ),
      title: Text(
        StringConstants.articleDetail,
        style: Theme.of(context).textTheme.headline2,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50.sp);
}
