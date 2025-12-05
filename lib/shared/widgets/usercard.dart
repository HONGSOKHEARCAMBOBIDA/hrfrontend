import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/core/theme/custom_theme/text_styles.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomUserCard extends StatelessWidget {
  final String namekh;
  final String nameenglish;
  final String role;
  final String branch;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onTap;
  final bool? isActive;

  const CustomUserCard({
    Key? key,
    required this.namekh,
    required this.nameenglish,
    required this.role,
    required this.branch,
    required this.onEdit,
    required this.onDelete,
    required this.onTap,
    this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
   
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.0),
      child: Padding(
        padding: const EdgeInsets.only(left: 13,top: 5,right: 2,bottom: 2),
        child: Row(
          children: [
            // Profile avatar with status indicator
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                        decoration: BoxDecoration(
      border: Border.all(
        color: TheColors.warningColor,// Border color
        width: 0.9,
      ),
      borderRadius: BorderRadius.circular(50),
    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: CachedNetworkImage(
                        imageUrl:
                            "https://cdn-icons-png.flaticon.com/128/428/428933.png",
                        width: 45,
                        height: 45,
                        fit: BoxFit.cover,
                        memCacheWidth: 100,
                        memCacheHeight: 100,
                        maxWidthDiskCache: 200,
                        maxHeightDiskCache: 200,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: isActive == true
                          ? TheColors.successColor
                          : TheColors.red,
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
            const SizedBox(width: 16),
            // User info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        namekh,
                        style: TextStyles.siemreap(
                          context,
                          fontSize: 12,
                          fontweight: FontWeight.bold,
                        ),
                      
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(width: 10,),
                      Text("("),
                      SizedBox(width: 2,),
                                            Text(
                        branch,
                        style: TextStyles.siemreap(
                          context,
                          fontSize: 10,
                          color: TheColors.secondaryColor
                        ),
                      
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                        SizedBox(width: 2,),
                         Text(")"),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          role,
                          style: GoogleFonts.siemreap(
                            // 👈 Replace with your font
                          color: TheColors.orange,fontSize: 10
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Action menu
            _buildActionMenu(context),
          ],
        ),
      ),
    );
  }

Widget _buildActionMenu(BuildContext context) {
  final theme = Theme.of(context);

  return PopupMenuButton<String>(
    icon: Icon(
      Icons.more_vert,
      color: theme.iconTheme.color?.withOpacity(0.7),
    ),
    padding: EdgeInsets.zero,
    color: TheColors.bgColor,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      side: BorderSide(
        color: TheColors.orange,
        width: 1,
      ),
    ),
    onSelected: (value) {
      if (value == 'edit') {
        onEdit();
      } else if (value == 'delete') {
        onDelete();
      }
    },
    itemBuilder: (context) => [
      PopupMenuItem(
        value: 'edit',
        child: Row(
          children: [
            Icon(Icons.edit, color: TheColors.orange, size: 20),
            const SizedBox(width: 12),
            Text('កែប្រែ', style: TextStyles.siemreap(context, fontSize: 12)),
          ],
        ),
      ),
      PopupMenuItem(
        value: 'delete',
        child: Row(
          children: [
            Icon(
              isActive == true ? Icons.block : Icons.check_circle,
              color: isActive == true
                  ? TheColors.errorColor
                  : TheColors.successColor,
              size: 20,
            ),
            const SizedBox(width: 12),
            Text(
              isActive == true ? 'បិទ' : 'បើក',
              style: TextStyles.siemreap(context, fontSize: 12),
            ),
          ],
        ),
      ),
    ],
  );
}

}
