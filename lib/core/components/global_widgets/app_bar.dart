import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(context) {
    return AppBar(
      backgroundColor: Colors.tealAccent[400],
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
          color: Colors.white,
        ),
      ),
      title: Text(
        "Article Detail",
        style: Theme.of(context).textTheme.headline2,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50.sp);
}
