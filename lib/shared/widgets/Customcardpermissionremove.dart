import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/core/theme/custom_theme/text_styles.dart';
import 'package:flutter_application_10/data/models/rolepermission.dart'
    as mymodel;

class Customcardpermissionremove extends StatelessWidget {
  final mymodel.Data permission;
  final ValueChanged<bool?> onChanged;

  const Customcardpermissionremove({
    Key? key,
    required this.permission,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isAssigned = permission.assigned ?? false;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      shadowColor: theme.colorScheme.shadow.withOpacity(0.1),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          if (isAssigned) {
            // Permission is currently assigned and now being removed
            onChanged(false); // Or pass permission.id if needed
          }
        },
        splashColor: theme.colorScheme.primary.withOpacity(0.1),
        highlightColor: theme.colorScheme.primary.withOpacity(0.05),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Custom checkbox with better visual feedback
              Container(
                margin: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isAssigned
                        ? TheColors.primaryColor
                        : theme.dividerColor,
                    width: 2,
                  ),
                  color: isAssigned
                      ? TheColors.secondaryColor
                      : TheColors.errorColor,
                ),
                child: Icon(
                  Icons.check,
                  size: 18,
                  color: isAssigned
                      ? theme.colorScheme.onPrimary
                      : Colors.transparent,
                ),
              ),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                               Text(
                          permission.displayName ?? 'No Name',
                           style: TextStyles.siemreap(context,fontSize: 12,fontweight: FontWeight.bold),
                          ),
                          SizedBox(width: 5,),
                          
                      
                          Text(
                            permission.name ?? 'No Name',
                            style: theme.textTheme.bodyLarge?.copyWith(
                              fontSize: 12,
                              color: TheColors.errorColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Visual indicator for enabled/disabled
              Container(
                width: 12,
                height: 12,
                margin: const EdgeInsets.only(left: 8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isAssigned
                      ? TheColors.secondaryColor
                      : TheColors.errorColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
