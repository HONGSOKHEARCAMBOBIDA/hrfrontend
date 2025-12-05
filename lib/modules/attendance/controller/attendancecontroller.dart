import 'package:flutter_application_10/data/models/attendancemodel.dart' as mymodel;
import 'package:flutter_application_10/data/models/employeeshiftmodel.dart';
import 'package:flutter_application_10/modules/attendance/service/attendanceservice.dart';
import 'package:flutter_application_10/shared/widgets/snackbar.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

class Attendancecontroller extends GetxController {
  final Attendanceservice attendanceservice = Attendanceservice();

  var employeeshift = <Data>[].obs;
  var attendance = <mymodel.Data>[].obs;
  var selectedShiftId = Rxn<int>();
    final RxString searchQuery = ''.obs;
  var isLoading = false.obs;

  // Reactive latitude and longitude
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();
    fetchemployeeshift();
    fetchattendance();
       debounce(
      searchQuery, // Rx value to watch
      (_) => fetchattendance(name: searchQuery.value), // Action to run
      time: const Duration(milliseconds: 200), // Wait 500ms after last input
    );
  }


  void selectShift(int id) {
    if (selectedShiftId.value == id) {
      selectedShiftId.value = null;
    } else {
      selectedShiftId.value = id;
    }
  }
  Future<void> fetchattendance({
        int? branchID,
    int? islate,
    int? isLeftEarly,
    String? name,
    String? startdate,
    String? enddate,

  })async{
    try{
    isLoading.value= true;
    final result = await attendanceservice.getattendance(
      branchID: branchID,
      islate: islate,
      isLeftEarly: isLeftEarly,
      name: name,
      startdate: startdate,
      enddate: enddate
    );
    attendance.assignAll(result);

    }catch(e){
      CustomSnackbar.error(title: "បញ្ហា", message: e.toString());
    }finally{
      isLoading.value = false;
    }
  }
  Future<void> fetchemployeeshift() async {
    try {
      isLoading.value = true;
      final result = await attendanceservice.getemployeeshift();
      employeeshift.assignAll(result);
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> checkin({required int employeeshiftid}) async {
    try {
      isLoading.value = true;
      bool created = await attendanceservice.checkin(
        employeeshiftid: employeeshiftid,
        latitube: latitude.value,
        longitude: longitude.value,
      );
      if (created) {
        CustomSnackbar.success(title: "ជោគជ័យ", message: "សូមអរគុណ");
      }
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> checkout({required int employee_shiftid}) async {
    try {
      isLoading.value = true;
      bool created = await attendanceservice.checkout(
        employee_shiftid: employee_shiftid,
        latitube: latitude.value,
        longitude: longitude.value,
      );
      if (created) {
        CustomSnackbar.success(title: "ជោគជ័យ", message: "សូមអរគុណ");
      }
    } catch (e) {
      CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // New method: get current location and update reactive values
Future<void> getCurrentLocation() async {
  try {
    isLoading.value = true;

    // 1. Check permission quickly
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar("ការព្រមាន", "សូមអនុញ្ញាតឱ្យកម្មវិធីប្រើទីតាំង។");
        return;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Get.snackbar("បដិសេធ", "សូមបើកការអនុញ្ញាតទីតាំងក្នុងការកំណត់។");
      return;
    }

    // 2. Very fast: get cached location
    Position? position = await Geolocator.getLastKnownPosition();

    if (position != null) {
      latitude.value = position.latitude;
      longitude.value = position.longitude;
      return;
    }

    // 3. If no cache → get GPS fast with low accuracy + timeout
    position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low, // fastest
    ).timeout(
      const Duration(seconds: 3),
      onTimeout: () => throw "Location timeout",
    );

    latitude.value = position.latitude;
    longitude.value = position.longitude;

  } catch (e) {
    CustomSnackbar.error(title: "មានបញ្ហា", message: e.toString());
  } finally {
    isLoading.value = false;
  }
}

}
