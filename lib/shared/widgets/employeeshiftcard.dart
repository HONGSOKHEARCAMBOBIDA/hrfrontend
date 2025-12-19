import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/core/theme/custom_theme/text_styles.dart';
import 'package:flutter_application_10/data/models/employeeshiftmodel.dart';

class Employeeshiftcard extends StatelessWidget {
  final Data employeeshiftmodel;
  final bool isSelected;
  final VoidCallback onTap;

  const Employeeshiftcard({
    Key? key,
    required this.employeeshiftmodel,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      color: isSelected
          ? TheColors.warningColor
          : Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),
    
      
      ),
      
      shadowColor: theme.colorScheme.shadow.withOpacity(0.1),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        splashColor: theme.colorScheme.primary.withOpacity(0.1),
        highlightColor: theme.colorScheme.primary.withOpacity(0.05),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected
                        ? TheColors.errorColor
                        : theme.dividerColor,
                    width: 1,
                  ),
                  color: isSelected
                      ? TheColors.errorColor
                      : Colors.transparent,
                ),
                child: Icon(
                  Icons.check,
                  size: 18,
                  color: isSelected ? Colors.white : Colors.transparent,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      employeeshiftmodel.shiftName ?? 'No Name',
                      style: TextStyles.siemreap(
                        context,
                        fontSize: 13,
                        fontweight: FontWeight.bold,
                        color: isSelected ? TheColors.errorColor : TheColors.black
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          employeeshiftmodel.startTime.toString(),
                          style: TextStyles.siemreap(
                            context,
                            fontSize: 12,
                            color: TheColors.errorColor,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          employeeshiftmodel.endTime.toString(),
                          style: TextStyles.siemreap(
                            context,
                            fontSize: 12,
                            color: TheColors.errorColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
