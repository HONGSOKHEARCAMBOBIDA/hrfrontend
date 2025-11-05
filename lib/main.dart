import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/theme/app_theme.dart';
import 'package:flutter_application_10/modules/attendance/binding/attendancebinding.dart';
import 'package:flutter_application_10/modules/attendance/view/attendanceview.dart';
import 'package:flutter_application_10/modules/attendance/view/createattendanceview.dart';
import 'package:flutter_application_10/modules/auth/binding/authbinding.dart';
import 'package:flutter_application_10/modules/auth/view/loginview.dart';
import 'package:flutter_application_10/modules/auth/view/registerview.dart';
import 'package:flutter_application_10/modules/auth/view/userview.dart';
import 'package:flutter_application_10/modules/branch/brandbinding/branchbinding.dart';
import 'package:flutter_application_10/modules/branch/view/branchview.dart';
import 'package:flutter_application_10/modules/communce/communcebinding/communcebinding.dart';
import 'package:flutter_application_10/modules/district/districtbinding/districtbinding.dart';
import 'package:flutter_application_10/modules/employee/employeebinding/employeebinding.dart';
import 'package:flutter_application_10/modules/employee/employeeview/employeeview.dart';
import 'package:flutter_application_10/modules/leave/leavebinding/leavebinding.dart';
import 'package:flutter_application_10/modules/leave/leaveview/createleaveview.dart';
import 'package:flutter_application_10/modules/loan/loanbinding/loanbinding.dart';
import 'package:flutter_application_10/modules/loan/view/loanview.dart';
import 'package:flutter_application_10/modules/main/binding/mainbinding.dart';
import 'package:flutter_application_10/modules/main/mainmiddleware/mainmiddleware.dart';
import 'package:flutter_application_10/modules/main/mainview/mainview.dart';
import 'package:flutter_application_10/modules/main/mainview/splacescreen.dart';
import 'package:flutter_application_10/modules/main/mainview/test.dart';
import 'package:flutter_application_10/modules/province/provincebinding/provincebinding.dart';
import 'package:flutter_application_10/modules/role/rolebinding/rolebinding.dart';
import 'package:flutter_application_10/modules/shift/shiftbinding/shiftbinding.dart';
import 'package:flutter_application_10/modules/shift/view/shiftview.dart';
import 'package:flutter_application_10/modules/village/villagebinding/villagebinding.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
 
  await GetStorage.init();

  //print token
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: AppTheme.lightTheme,
      // darkTheme: AppTheme.darkTheme,
      initialRoute: '/main',
      getPages: [
        GetPage(
          name: '/main', 
          middlewares: [MainMiddleware()],
          page: ()=> MainView(),
          
          bindings: [MainBinding(),Attendancebinding()]),
        GetPage(
          name: '/login', 
          page: ()=> LoginView(),
          binding: Authbinding()),
        GetPage(
  name: '/register',
  page: () => Registerview(),
  bindings: [
    Authbinding(),
    Provincebinding(),
    Districtbinding(),
    Communcebinding(),
    Villagebinding(),
    Rolebinding(),
    Branchbinding(),
    Shiftbinding()

  ]
),

GetPage(
  name: '/listuser', 
  page: ()=>Userview(),
  bindings: [
    Authbinding(),
    Rolebinding(),
    Branchbinding()
  ]
  ),
  GetPage(
  name: '/listemployee', 
  page: ()=>Employeeview(),
  bindings: [
    Employeebinding(),
    Rolebinding(),
    Branchbinding(),
    Shiftbinding(),
  ]
  ),
  GetPage(
    name: '/branch', 
    page: ()=>Branchview(),
    binding: Branchbinding()
    ),
      GetPage(
    name: '/shift', 
    page: ()=>Shiftview(),
    bindings: [Branchbinding(),Shiftbinding()]
    ),
    GetPage(
      name: '/attendance', 
      page: ()=>Createattendanceview(),
      binding: Attendancebinding()),
    GetPage(
      name: '/viewattendance', 
      page: ()=> Attendanceview(),
      bindings: [Branchbinding(),Attendancebinding()]),
    GetPage(
      name: '/loan', 
      page: ()=> LoanView(),
      bindings:[
        Loanbinding(),
        Branchbinding(),
        Employeebinding()
      ] 
      ),
    GetPage(
      name: '/leave', 
      page: ()=>CreateLeaveView(),
      bindings: [
        Leavebinding(),
        Authbinding()
      ]
      )



      ],
    );
  }
}



