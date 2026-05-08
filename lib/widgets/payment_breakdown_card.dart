import 'package:flutter/material.dart';

import '../core/utils.dart';
import '../models/payment_breakdown.dart';

class PaymentBreakdownCard extends StatelessWidget {
  final PaymentBreakdown breakdown;

  const PaymentBreakdownCard({
    super.key,
    required this.breakdown,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(26),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1F000000),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.lock,
                color: Colors.white,
              ),
              SizedBox(width: 8),
              Text(
                'Desglose protegido',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _PaymentRow(
            label: 'Monto bruto',
            value: money(breakdown.gross),
          ),
          _PaymentRow(
            label: 'Retención SUNAT 8%',
            value: '- ${money(breakdown.taxRetention)}',
          ),
          _PaymentRow(
            label: 'Comisión TKOH 5%',
            value: '- ${money(breakdown.platformFee)}',
          ),
          const Divider(
            color: Color(0xFF334155),
            height: 28,
          ),
          _PaymentRow(
            label: 'Neto trabajador',
            value: money(breakdown.workerNet),
            strong: true,
          ),
          if (breakdown.commissionZeroDisabled) ...[
            const SizedBox(height: 12),
            const Text(
              'Aviso: beneficio Premium de comisión cero desactivado porque el servicio supera S/ 1,500.',
              style: TextStyle(
                color: Color(0xFFFDE68A),
                height: 1.35,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _PaymentRow extends StatelessWidget {
  final String label;
  final String value;
  final bool strong;

  const _PaymentRow({
    required this.label,
    required this.value,
    this.strong = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: strong ? Colors.white : const Color(0xFFCBD5E1),
              fontWeight: strong ? FontWeight.w900 : FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontWeight: strong ? FontWeight.w900 : FontWeight.w700,
              fontSize: strong ? 18 : 14,
            ),
          ),
        ],
      ),
    );
  }
}