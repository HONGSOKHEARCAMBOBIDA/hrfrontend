class Userupdatemodel {
  final int ID;
  final int branchID;
  final String nameEn;
  final String nameKh;
  final String username;
  final String email;
  final int gender;
  final String contact;
  final String nationalIdNumber;
  final DateTime dob;
  final int villageId;
  final int roleId;

  Userupdatemodel({
    required this.ID,
    required this.branchID,
    required this.nameEn,
    required this.nameKh,
    required this.username,
    required this.email,
    required this.gender,
    required this.contact,
    required this.nationalIdNumber,
    required this.dob,
    required this.villageId,
    required this.roleId,
  });

  /// Convert to JSON (for API)
  Map<String, dynamic> toJson() {
    return {
      'id':ID,
      'branch_id': branchID,
      'name_en': nameEn,
      'name_kh': nameKh,
      'username': username,
      'email': email,
      'gender': gender,
      'dob': dob.toIso8601String(),
      'contact': contact,
      'national_id_number': nationalIdNumber,
      'village_id': villageId,
      'role_id': roleId,
    };
  }
}
