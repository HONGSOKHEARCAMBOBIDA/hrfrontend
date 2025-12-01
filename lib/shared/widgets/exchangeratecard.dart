import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/core/theme/custom_theme/text_styles.dart';
import 'package:google_fonts/google_fonts.dart';

class ExchangeRateCard extends StatelessWidget {
  final String baseCurrencyCode;
  final String baseCurrencySymbol;
  final String baseCurrencyName;

  final String targetCurrencyCode;
  final String targetCurrencySymbol;
  final String targetCurrencyName;

  final String createByName;
  final String updateByName;

  final String rate;

  final VoidCallback onEdit;
  final VoidCallback onToggleStatus;

  final int? isActive; // 1 = active, 0 = inactive

  const ExchangeRateCard({
    Key? key,
    required this.rate,
    required this.baseCurrencyCode,
    required this.baseCurrencySymbol,
    required this.baseCurrencyName,
    required this.targetCurrencyCode,
    required this.targetCurrencySymbol,
    required this.targetCurrencyName,
    required this.createByName,
    required this.updateByName,
    required this.onEdit,
    required this.onToggleStatus,
    
    this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onEdit,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // LEFT SIDE — CURRENCY INFO
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Base → Target
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "$baseCurrencyCode ($baseCurrencySymbol)",
                            style: TextStyles.siemreap(
                              context,
                              fontSize: 12,
                              fontweight: FontWeight.bold,
                            ),
                          ),
                          Text("  →  "),
                      Text(
                        "$targetCurrencyCode ($targetCurrencySymbol)",
                        style: TextStyles.siemreap(
                          context,
                          fontSize: 12,
                          fontweight: FontWeight.bold,
                          color: TheColors.orange,
                        ),
                      ),
                        ],
                      ),
                      
                      Row(
                        children: [
                          Text("អត្រារ",style: TextStyles.siemreap(context,fontSize: 12),),
                          SizedBox(width: 20,),
                          Text("$rate",style: 
                          TextStyles.siemreap
                          (context,fontweight: FontWeight.bold,fontSize: 13,color: TheColors.errorColor),)
                        ],
                      )
                    ],
                  ),

                  const SizedBox(height: 6),

                  // Names (Khmer)
                  Text(
                    "$baseCurrencyName → $targetCurrencyName",
                    style: TextStyles.siemreap(
                      context,
                      fontSize: 11,
                      color: TheColors.secondaryColor,
                    ),
                  ),

                  const SizedBox(height: 6),

                  // Created + Updated by
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "បង្កើតដោយ: $createByName",
                        style: GoogleFonts.siemreap(
                          fontSize: 10,
                          color: TheColors.successColor,
                        ),
                      ),
                                        Text(
                    "កែប្រែដោយ: $updateByName",
                    style: GoogleFonts.siemreap(
                      fontSize: 10,
                      color: TheColors.secondaryColor,
                    ),
                  ),
                    ],
                  ),

                ],
              ),
            ),

            // RIGHT SIDE — ACTION MENU
            _buildActionMenu(context),
          ],
        ),
      ),
    );
  }

  Widget _buildActionMenu(BuildContext context) {
    final isActiveBool = isActive == 1;

    return PopupMenuButton<String>(
      icon: Icon(Icons.more_vert, color: Colors.grey[700]),
      padding: EdgeInsets.zero,
      color: TheColors.bgColor,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: TheColors.orange),
      ),
      onSelected: (value) {
        if (value == 'edit') {
          onEdit();
        } else if (value == 'toggle') {
          onToggleStatus();
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
          value: 'toggle',
          child: Row(
            children: [
              Icon(
                isActiveBool ? Icons.block : Icons.check_circle,
                color:
                    isActiveBool ? TheColors.errorColor : TheColors.successColor,
                size: 20,
              ),
              const SizedBox(width: 12),
              Text(
                isActiveBool ? 'បិទ' : 'បើក',
                style: TextStyles.siemreap(context, fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
