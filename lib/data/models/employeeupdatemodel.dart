class Employeeupdatemodel {
  final int ID;
  final int branchID;
  final String nameEn;
  final String nameKh;
  final int gender;
  final String contact;
  final String nationalIdNumber;
  final DateTime dob;
  final int villageId;
  final int roleId;
  final DateTime hireDate;
  final int type;

  Employeeupdatemodel({
    required this.ID,
    required this.branchID,
    required this.nameEn,
    required this.nameKh,
    required this.gender,
    required this.contact,
    required this.nationalIdNumber,
    required this.dob,
    required this.villageId,
    required this.roleId,
    required this.hireDate,
    required this.type
  });

  /// Convert to JSON (for API)
  Map<String, dynamic> toJson() {
    return {
      'id':ID,
      'branch_id': branchID,
      'name_en': nameEn,
      'name_kh': nameKh,
      'gender': gender,
      'dob': dob.toIso8601String(),
      'contact': contact,
      'national_id_number': nationalIdNumber,
      'village_id': villageId,
      'role_id': roleId,
      'hire_date':hireDate.toIso8601String(),
      'type':type
    };
  }
}
