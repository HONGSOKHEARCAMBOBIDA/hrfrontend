class Userupdatemodel {
  final int ID;
  final int branchID;
  final String username;
  final String email;
  final String contact;
  final int roleId;
  final List<int> partIds; // Rename from 'parts' to 'partIds' for clarity

  Userupdatemodel({
    required this.ID,
    required this.branchID,
    required this.username,
    required this.email,
    required this.contact,
    required this.roleId,
    required this.partIds, // Renamed
  });

  /// Convert to JSON (for API)
  Map<String, dynamic> toJson() {
    return {
    'branch_id': branchID,
    'username': username,
    'email': email,
    'contact': contact,
    'role_id': roleId,
    'part_ids': partIds,
    };
  }
}