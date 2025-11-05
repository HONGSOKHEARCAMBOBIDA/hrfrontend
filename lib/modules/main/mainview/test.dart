// import 'package:flutter/material.dart';
// import 'package:flutter_application_10/core/helper/show_province_buttonsheet.dart';


// class EditProfilePage extends StatefulWidget {
//   @override
//   _EditProfilePageState createState() => _EditProfilePageState();
// }

// class _EditProfilePageState extends State<EditProfilePage> {
//   String? selectedProvince;
//   List<String> provinces = []; // will come from backend

//   @override
//   void initState() {
//     super.initState();
//     _loadProvincesFromBackend();
//   }

//   Future<void> _loadProvincesFromBackend() async {
//     // Example: replace this with your actual API call
//     await Future.delayed(const Duration(milliseconds: 500));
//     setState(() {
//       provinces = [
//         'Phnom Penh', 'Kandal', 'Takeo', 'Siem Reap', 'Battambang',
//       ];
//     });
//   }

//   void _showProvinceSheet() {
//     showProvinceSelectorSheet(
//       context: context,
//       provinces: provinces,
//       selectedProvince: selectedProvince,
//       onSelected: (province) {
//         setState(() {
//           selectedProvince = province;
//         });
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Edit Profile')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(selectedProvince ?? 'No province selected'),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _showProvinceSheet,
//               child: const Text('Select Province'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
