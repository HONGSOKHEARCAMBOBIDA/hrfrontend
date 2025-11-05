import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/core/theme/custom_theme/text_styles.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:popover/popover.dart';

class Shiftcard extends StatelessWidget {
  final String name;
  final String startTime;
  final String endTime;
  final VoidCallback onEdit;
  final VoidCallback onToggleStatus;
  final int? isActive;

  const Shiftcard({
    Key? key,
    required this.startTime,
    required this.endTime,
    required this.name,
    required this.onEdit,
    required this.onToggleStatus,
    this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 🏢 Shift icon + active indicator
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: CachedNetworkImage(
                  imageUrl:
                      "https://cdn-icons-png.flaticon.com/128/14721/14721700.png",
                  width: 48,
                  height: 48,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 2,
                right: 2,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: isActive == 1
                        ? TheColors.successColor
                        : TheColors.errorColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isDarkMode ? Colors.grey[850]! : Colors.white,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(width: 12),

          // 🕒 Shift information
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyles.siemreap(
                    context,
                    fontSize: 12,
                    fontweight: FontWeight.bold,
                    color: TheColors.secondaryColor,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time_rounded,
                      size: 14,
                      color: TheColors.primaryColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "ម៉ោងចូល: $startTime   ម៉ោងចេញ: $endTime",
                      style: TextStyles.siemreap(
                        context,
                        fontSize: 10,
                        color: TheColors.gray,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ⋮ Action Menu
          _buildActionMenu(context),
        ],
      ),
    );
  }

  // 📋 Popover Action Menu
  Widget _buildActionMenu(BuildContext context) {
    final theme = Theme.of(context);

    return Builder(
      builder: (innerContext) {
        return IconButton(
          icon: Icon(
            Icons.more_vert,
            color: theme.iconTheme.color?.withOpacity(0.7),
          ),
          padding: EdgeInsets.zero,
          onPressed: () {
            showPopover(
              context: innerContext,
              bodyBuilder: (context) => Material(
                elevation: 6,
                color: TheColors.bgColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildMenuItem(
                      context,
                      icon: Icons.edit,
                      color: theme.colorScheme.primary,
                      text: 'កែប្រែ',
                      onTap: onEdit,
                    ),
                    _buildMenuItem(
                      context,
                      icon: isActive == 1
                          ? Icons.block
                          : Icons.check_circle_outline,
                      color: isActive == 1
                          ? TheColors.errorColor
                          : TheColors.successColor,
                      text: isActive == 1 ? 'បិទវេន' : 'បើកវេន',
                      onTap: () => _confirmToggleStatus(context),
                    ),
                  ],
                ),
              ),
              direction: PopoverDirection.bottom,
              width: 140,
              height: 90,
              arrowHeight: 10,
              arrowWidth: 20,
              radius: 8,
            );
          },
        );
      },
    );
  }

  // 🔹 Menu Item Builder
  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required Color color,
    required String text,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: color, size: 16),
            const SizedBox(width: 10),
            Text(
              text,
              style: TextStyles.siemreap(context, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  // ⚠️ Confirm Toggle Status Dialog
  void _confirmToggleStatus(BuildContext context) {
    final actionText = isActive == 1 ? 'បិទ' : 'បើក';
    final confirmMessage = isActive == 1
        ? 'តើអ្នកពិតជាចង់បិទវេននេះមែនទេ?'
        : 'តើអ្នកពិតជាចង់បើកវេននេះមែនទេ?';

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          'បញ្ជាក់',
          style: GoogleFonts.siemreap(fontWeight: FontWeight.bold),
        ),
        content: Text(confirmMessage, style: GoogleFonts.siemreap()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('បោះបង់', style: GoogleFonts.siemreap()),
          ),
          TextButton(
            onPressed: () {
              onToggleStatus();
              Get.back();
            },
            child: Text(actionText, style: GoogleFonts.siemreap()),
          ),
        ],
      ),
    );
  }
}
