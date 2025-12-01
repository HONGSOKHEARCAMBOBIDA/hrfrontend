import 'package:flutter/material.dart';
import 'package:flutter_application_10/core/theme/constants/the_colors.dart';
import 'package:flutter_application_10/core/theme/custom_theme/text_styles.dart';
import 'package:flutter_application_10/data/models/currencypairmodel.dart';
import 'package:google_fonts/google_fonts.dart';

class CurrencyPairCard extends StatelessWidget {
  final Data currencyPair;
  final VoidCallback? onTap;
  final bool isSelected;

  const CurrencyPairCard({
    Key? key,
    required this.currencyPair,
    this.onTap,
    this.isSelected = false,
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
              // Header with currency pair
              _buildCurrencyPairHeader(),
              const SizedBox(height: 12),
              // Currency details
              _buildCurrencyDetails(),
              const SizedBox(height: 8),
              // Status indicator
              _buildStatusIndicator(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCurrencyPairHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${currencyPair.baseCurrencyCode} → ${currencyPair.targetCurrencyCode}',
                style: GoogleFonts.siemreap(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: TheColors.secondaryColor,
                ),
                
              ),
              const SizedBox(height: 4),
              Text(
                '${currencyPair.baseCurrencyName} to ${currencyPair.targetCurrencyName}',
                style: GoogleFonts.siemreap(
                  fontSize: 12,
                  color: TheColors.errorColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'ID: ${currencyPair.id}',
            style: TextStyle(
              fontSize: 12,
              color: Colors.blue.shade800,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCurrencyDetails() {
    return Row(
      children: [
        Expanded(
          child: _buildCurrencyInfo(
            symbol: currencyPair.baseCurrencySymbol ?? '',
            code: currencyPair.baseCurrencyCode ?? '',
            isActive: currencyPair.baseCurrencyIsActive ?? false,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Icon(
            Icons.arrow_forward,
            size: 16,
            color: Colors.grey,
          ),
        ),
        Expanded(
          child: _buildCurrencyInfo(
            symbol: currencyPair.targetCurrencySymbol ?? '',
            code: currencyPair.targetCurrencyCode ?? '',
            isActive: currencyPair.targetCurrencyIsActive ?? false,
          ),
        ),
      ],
    );
  }

  Widget _buildCurrencyInfo({
    required String symbol,
    required String code,
    required bool isActive,
  }) {
    return Container(
      padding: const EdgeInsets.all(8),
             margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10,),
          border: Border.all(color: TheColors.orange,width: 0.5)
      ),
      child: Column(
        children: [
          Text(
            symbol,
            style: GoogleFonts.siemreap(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isActive ? Colors.green.shade800 : Colors.red.shade800,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            code,
            style: GoogleFonts.siemreap(
              fontSize: 10,
              color: TheColors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusIndicator() {
    final bool isPairActive = currencyPair.isActive ?? false;
    final bool isBaseActive = currencyPair.baseCurrencyIsActive ?? false;
    final bool isTargetActive = currencyPair.targetCurrencyIsActive ?? false;

    return Row(
      children: [
        _buildStatusDot(
          'Pair Active',
          isPairActive ? Colors.green : Colors.red,
        ),
        const SizedBox(width: 8),
        _buildStatusDot(
          'Base',
          isBaseActive ? Colors.green : Colors.red,
        ),
        const SizedBox(width: 8),
        _buildStatusDot(
          'Target',
          isTargetActive ? Colors.green : Colors.red,
        ),
      ],
    );
  }

  Widget _buildStatusDot(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}