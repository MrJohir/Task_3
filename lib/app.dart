import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:task_3/core/bindings/controller_binder.dart';
import 'package:task_3/core/utils/theme/theme.dart';
import 'package:task_3/features/notes/views/screens/notes_list_screen.dart';

/// main app widget
class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'Notes App',
          debugShowCheckedModeBanner: false,
          initialBinding: ControllerBinder(),
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,
          home: const NotesListScreen(),
          builder: EasyLoading.init(),
        );
      },
    );
  }
}
