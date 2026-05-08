import 'package:flutter/material.dart';

import '../../../core/utils.dart';

class BudgetCard extends StatelessWidget {
  final double budget;
  final ValueChanged<double> onChanged;

  const BudgetCard({
    super.key,
    required this.budget,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(22),
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
          const Text(
            'Presupuesto estimado',
            style: TextStyle(
              color: Color(0xFFCBD5E1),
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            money(budget),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.8,
            ),
          ),
          Slider(
            value: budget,
            min: 100,
            max: 3000,
            divisions: 29,
            label: money(budget),
            activeColor: const Color(0xFF14B8A6),
            inactiveColor: const Color(0xFF334155),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}