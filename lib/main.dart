import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/modules/app_pages.dart';
import 'package:get/get.dart' hide Condition;
import 'package:get_storage/get_storage.dart';
import 'package:responsive_framework/responsive_framework.dart';


void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes, // Using the list from the other file
      
      // Global Responsive Configuration
builder: (context, child) => ResponsiveBreakpoints.builder(
  child: Builder( // Use a Builder to provide a fresh context
    builder: (context) {
      return Container(
        color: TheColors.orange,
        child: MaxWidthBox(
          maxWidth: 1200,
          child: ResponsiveScaledBox(
            // Now context will correctly find the breakpoints
            width: ResponsiveValue<double>(context, conditionalValues: [
              const Condition.equals(name: MOBILE, value: 450),
              const Condition.equals(name: TABLET, value: 800),
              const Condition.equals(name: DESKTOP, value: 1200),
            ]).value ?? 450,
            child: child!,
          ),
        ),
      );
    },
  ),
  breakpoints: [
    const Breakpoint(start: 0, end: 450, name: MOBILE),
    const Breakpoint(start: 451, end: 800, name: TABLET),
    const Breakpoint(start: 801, end: 1920, name: DESKTOP),
  ],
),
    );
  }
}