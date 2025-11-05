import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/core/theme/custom_theme/text_styles.dart';
import 'package:flutter_application_10/modules/main/maincontroller/maincontroller.dart';
import 'package:flutter_application_10/modules/role/rolebinding/rolebinding.dart';
import 'package:flutter_application_10/modules/role/roleview/roleview.dart';
import 'package:flutter_application_10/shared/widgets/app_bar.dart';
import 'package:get/get.dart';

class a extends GetView<MainController> {
  const a({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "A"),
      drawer: Drawer(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
               SizedBox(
                height: 82,
                 child: const DrawerHeader(
                               
                               decoration: BoxDecoration(
                  
                  color: TheColors.errorColor, // same as your app theme
                               ),
                               child: Center(
                                 child: Text(
                                   '',
                                   style: TextStyle(color: Colors.white, fontSize: 24),
                                 ),
                               ),
                             ),
               ),
               ListTile(
              leading: const Icon(Icons.person,color: TheColors.errorColor,),
              title:  Text('អ្នកប្រេីប្រាស់',style: TextStyles.siemreap(context,fontSize: 12),),
              onTap: () {
                Get.toNamed('/listuser'); // Navigate to Register page
              },
            ),
            Divider(),
            
            ListTile(
              leading: const Icon(Icons.person_add,color: TheColors.errorColor,),
              title:  Text('បង្កេីតអ្នកប្រេីប្រាស់',style: TextStyles.siemreap(context,fontSize: 12),),
              onTap: () {
                Get.toNamed('/register'); // Navigate to Register page
              },
            ),
                        Divider(),
            
            ListTile(
              leading: const Icon(Icons.admin_panel_settings,color: TheColors.errorColor,),
              title:  Text('តួនាទី',style: TextStyles.siemreap(context,fontSize: 12),),
              onTap: () {
               Get.to(()=>Roleview(),binding: Rolebinding(),transition: Transition.rightToLeft);
              },
            ),
               Divider(),         
            ListTile(
              leading: const Icon(Icons.person_2_sharp,color: TheColors.errorColor,),
              title:  Text('បុគ្គលិក',style: TextStyles.siemreap(context,fontSize: 12),),
              onTap: () {
               Get.toNamed('/listemployee'); 
              },
            ),
             Divider(),   
                        ListTile(
              leading: const Icon(Icons.home_work,color: TheColors.errorColor,),
              title:  Text('សាខា',style: TextStyles.siemreap(context,fontSize: 12),),
              onTap: () {
               Get.toNamed('/branch'); 
              },
            ),
               Divider(),   
            ListTile(
              leading: const Icon(Icons.lock_clock,color: TheColors.errorColor,),
              title:  Text('វេនធ្វេីការ',style: TextStyles.siemreap(context,fontSize: 12),),
              onTap: () {
               Get.toNamed('/shift'); 
              },
            ),
            Divider(),
            ListTile(
              leading: const Icon(Icons.logout,color: TheColors.errorColor,),
              title:  Text('ចាកចេញ',style: TextStyles.siemreap(context,fontSize: 12),),
              onTap: () {
                controller.logout();
              },
            ),
            Divider()
          ],
        ),
      ),

    );
  }
}
