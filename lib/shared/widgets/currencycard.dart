import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/core/theme/custom_theme/text_styles.dart';
import 'package:flutter_application_10/data/models/currencymodel.dart';

class CurrencyCard extends StatelessWidget {
  final Data currency;
  final bool isSelected;
  final VoidCallback? onTap;
  final double elevation;
  final Color? backgroundColor;
  final bool showDetails;

  const CurrencyCard({
    Key? key,
    required this.currency,
    this.isSelected = false,
    this.onTap,
    this.elevation = 2.0,
    this.backgroundColor,
    this.showDetails = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
       margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18,),
          border: Border.all(color: TheColors.orange,width: 0.5)
        ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with Code and Symbol
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    currency.code ?? 'N/A',
                    style: TextStyles.siemreap(context,fontweight: FontWeight.bold,fontSize: 19),
                  ),
                  Text(
                    currency.symbol ?? '',
                    style: TextStyles.siemreap(context,color: TheColors.secondaryColor,fontweight: FontWeight.bold,fontSize: 17)
                  ),
                ],
              ),
              
              const SizedBox(height: 8),
              
              // Currency Name
              Text(
                currency.name ?? 'Unknown Currency',
                style: TextStyles.siemreap(context,fontSize: 12,color: TheColors.secondaryColor)
              ),
              
              if (showDetails) ...[
                const SizedBox(height: 12),
                
                // Details Section
                Row(
                  children: [
                    _buildStatusIndicator(context),
                    const SizedBox(width: 8),
                    Text(
                      currency.isActive == true ? 'Active' : 'Inactive',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: currency.isActive == true 
                                ? TheColors.successColor 
                                : TheColors.errorColor
                          ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusIndicator(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: currency.isActive == true ? Colors.green : Colors.grey,
        shape: BoxShape.circle,
      ),
    );
  }

  Color _getCardColor(BuildContext context) {
    if (isSelected) {
      return Theme.of(context).primaryColor.withOpacity(0.1);
    }
    return Theme.of(context).cardColor;
  }
}

// Compact version for lists
class CompactCurrencyCard extends StatelessWidget {
  final Data currency;
  final VoidCallback? onTap;
  final bool isSelected;

  const CompactCurrencyCard({
    Key? key,
    required this.currency,
    this.onTap,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      elevation: 1,
      color: isSelected 
          ? Theme.of(context).primaryColor.withOpacity(0.1)
          : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: isSelected
            ? BorderSide(color: Theme.of(context).primaryColor, width: 1)
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Currency Symbol
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    currency.symbol ?? '?',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
              
              const SizedBox(width: 12),
              
              // Currency Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currency.code ?? 'N/A',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      currency.name ?? 'Unknown',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                          ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              
              // Status Indicator
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: currency.isActive == true ? Colors.green : Colors.grey,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Usage examples:
/*
// Basic usage
CurrencyCard(currency: currencyData)

// With selection
CurrencyCard(
  currency: currencyData,
  isSelected: true,
  onTap: () => print('Selected ${currencyData.code}'),
)

// Compact version for lists
CompactCurrencyCard(
  currency: currencyData,
  onTap: () => handleCurrencySelection(currencyData),
)

// In a ListView
ListView.builder(
  itemCount: currencyList.length,
  itemBuilder: (context, index) {
    return CurrencyCard(currency: currencyList[index]);
  },
)

// Grid layout
GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing: 8,
    mainAxisSpacing: 8,
  ),
  itemCount: currencyList.length,
  itemBuilder: (context, index) {
    return CurrencyCard(
      currency: currencyList[index],
      showDetails: false,
    );
  },
)
*/