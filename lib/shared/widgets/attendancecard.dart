import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/core/theme/custom_theme/text_styles.dart';

class CustomAttendanceCard extends StatelessWidget {
  final String nameKh;
  final String nameEn;
  final String role;
  final String checkIn;
  final String checkOut;
  final String shiftName;
  final String branchName;
  final String checkDate;
  final int isLate;
  final int? isLeftEarly;
  final String? latitudeCheckIn;
  final String? longitudeCheckIn;
  final String? latitudeCheckOut;
  final String? longitudeCheckOut;
  final bool? isZoonCheckIn;
  final bool? isZoonCheckOut;
  final String? notes;
  final VoidCallback onTap;
  final VoidCallback? onViewCheckInLocation;
  final VoidCallback? onViewCheckOutLocation;

  const CustomAttendanceCard({
    super.key,
    required this.nameKh,
    required this.nameEn,
    required this.role,
    required this.checkIn,
    required this.checkOut,
    required this.shiftName,
    required this.branchName,
    required this.checkDate,
    required this.isLate,
    required this.isLeftEarly,
    this.latitudeCheckIn,
    this.longitudeCheckIn,
    this.latitudeCheckOut,
    this.longitudeCheckOut,
    this.isZoonCheckIn,
    this.isZoonCheckOut,
    this.notes,
    required this.onTap,
    this.onViewCheckInLocation,
    this.onViewCheckOutLocation,
  });

  @override
  Widget build(BuildContext context) {
    final bool late = isLate == 1;
    final bool leftEarly = (isLeftEarly ?? 0) == 1;
    final bool hasCheckInLocation = latitudeCheckIn != null && longitudeCheckIn != null;
    final bool hasCheckOutLocation = latitudeCheckOut != null && longitudeCheckOut != null;
    final bool hasNotes = notes != null && notes!.isNotEmpty;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: TheColors.bgColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: TheColors.orange.withOpacity(0.5), width: 0.8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Row(
          children: [
            // Avatar
            CircleAvatar(
              radius: 26,
              backgroundColor: TheColors.secondaryColor.withOpacity(0.1),
              backgroundImage: const NetworkImage(
                "https://cdn-icons-png.flaticon.com/128/1828/1828640.png",
              ),
            ),
            const SizedBox(width: 12),
            // Info section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name
                  Row(
                    children: [
                      Text(
                        nameKh,
                        style: TextStyles.siemreap(
                          context,
                          fontSize: 13,
                          fontweight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "($nameEn)",
                        style: GoogleFonts.siemreap(
                          fontSize: 11,
                          color: TheColors.black.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  // Role
                  Row(
                    children: [
                      const Icon(Icons.badge_outlined, size: 14, color: TheColors.orange),
                      const SizedBox(width: 4),
                      Text(
                        role,
                        style: GoogleFonts.siemreap(
                          fontSize: 11,
                          color: TheColors.orange,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // Shift name & date
                  Row(
                    children: [
                      const Icon(Icons.access_time, size: 14, color: TheColors.secondaryColor),
                      const SizedBox(width: 4),
                      Text(
                        "$shiftName (${branchName})",
                        style: TextStyles.siemreap(context,
                            fontSize: 11, color: TheColors.secondaryColor),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        checkDate,
                        style: GoogleFonts.siemreap(
                          fontSize: 10,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // Check-in / Check-out
                  Row(
                    children: [
                      Icon(Icons.login, size: 14, color: TheColors.successColor),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          "ចូល៖ $checkIn",
                          style: TextStyles.siemreap(
                            context,
                            fontSize: 11,
                            color: TheColors.successColor,
                          ),
                        ),
                      ),
                      if (hasCheckInLocation)
                        InkWell(
                          onTap: onViewCheckInLocation,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.location_on, size: 14, color: TheColors.successColor),
                              const SizedBox(width: 2),
                              Text(
                                "មើលទីតាំងចូល",
                                style: TextStyles.siemreap(
                                  context,
                                  fontSize: 10,
                                  color: TheColors.successColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.logout, size: 14, color: TheColors.errorColor),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          "ចេញ៖ $checkOut",
                          style: TextStyles.siemreap(
                            context,
                            fontSize: 11,
                            color: TheColors.errorColor,
                          ),
                        ),
                      ),
                      if (hasCheckOutLocation)
                        InkWell(
                          onTap: onViewCheckOutLocation,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.location_on, size: 14, color: TheColors.errorColor),
                              const SizedBox(width: 2),
                              Text(
                                "មើលទីតាំងចេញ",
                                style: TextStyles.siemreap(
                                  context,
                                  fontSize: 10,
                                  color: TheColors.errorColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
// Location status
Row(
  children: [
    // Check-in location status
    Row(
      children: [
        Icon(
          isZoonCheckIn == true ? Icons.check_circle : Icons.cancel,
          size: 12,
          color: isZoonCheckIn == true ? TheColors.successColor : TheColors.errorColor,
        ),
        const SizedBox(width: 4),
        Text(
          isZoonCheckIn == true ? "ក្នុងតំបន់ចូល" : "ក្រៅតំបន់ចូល",
          style: TextStyles.siemreap(
            context,
            fontSize: 10,
            color: isZoonCheckIn == true ? TheColors.successColor : TheColors.errorColor,
          ),
        ),
      ],
    ),
    
    // Spacer between check-in and check-out status
    if (isZoonCheckIn != null && isZoonCheckOut != null) const SizedBox(width: 8),
    
    // Check-out location status
    if (isZoonCheckOut != null)
      Row(
        children: [
          Icon(
            isZoonCheckOut == true ? Icons.check_circle : Icons.cancel,
            size: 12,
            color: isZoonCheckOut == true ? TheColors.successColor : TheColors.errorColor,
          ),
          const SizedBox(width: 4),
          Text(
            isZoonCheckOut == true ? "ក្នុងតំបន់ចេញ" : "ក្រៅតំបន់ចេញ",
            style: TextStyles.siemreap(
              context,
              fontSize: 10,
              color: isZoonCheckOut == true ? TheColors.successColor : TheColors.errorColor,
            ),
          ),
        ],
      ),
  ],
),
                  const SizedBox(height: 4),
                  // Status (Late / Early)
                  Row(
                    children: [
                      if (late)
                        Row(
                          children: [
                            const Icon(Icons.warning_amber_rounded,
                                size: 14, color: TheColors.errorColor),
                            const SizedBox(width: 4),
                            Text(
                              "យឺត",
                              style: TextStyles.siemreap(context,
                                  fontSize: 11, color: TheColors.errorColor),
                            ),
                          ],
                        ),
                      if (late && leftEarly) const SizedBox(width: 8),
                      if (leftEarly)
                        Row(
                          children: [
                            const Icon(Icons.alarm_off_rounded,
                                size: 14, color: TheColors.secondaryColor),
                            const SizedBox(width: 4),
                            Text(
                              "ចេញមុន",
                              style: TextStyles.siemreap(context,
                                  fontSize: 11, color: TheColors.secondaryColor),
                            ),
                          ],
                        ),
                    ],
                  ),
                  // Notes
                  if (hasNotes)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          "កំណត់សម្គាល់: $notes",
                          style: TextStyles.siemreap(
                            context,
                            fontSize: 10,
                            color: TheColors.gray,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}