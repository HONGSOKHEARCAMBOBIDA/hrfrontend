class Userupdatemodel {
  final int ID;
  final int branchID;
  final String username;
  final String email;

  final String contact;

  final int roleId;

  Userupdatemodel({
    required this.ID,
    required this.branchID,

    required this.username,
    required this.email,

    required this.contact,

    required this.roleId,
  });

  /// Convert to JSON (for API)
  Map<String, dynamic> toJson() {
    return {
      'id': ID,
      'branch_id': branchID,

      'username': username,
      'email': email,

      'contact': contact,

      'role_id': roleId,
    };
  }
}
