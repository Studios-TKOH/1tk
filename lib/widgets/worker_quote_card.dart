import 'package:flutter/material.dart';

import '../core/utils.dart';
import '../models/worker_profile.dart';
import 'app_badge.dart';
import 'app_button.dart';
import 'mini_status.dart';

class WorkerQuoteCard extends StatelessWidget {
  final WorkerProfile worker;
  final double amount;
  final bool recommended;

  const WorkerQuoteCard({
    super.key,
    required this.worker,
    required this.amount,
    required this.recommended,
  });

  @override
  Widget build(BuildContext context) {
    final breakdown = calculatePayment(
      amount: amount,
      isPremiumWorker: worker.premium,
    );

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: recommended
              ? const Color(0xFF0F766E)
              : const Color(0xFFE2E8F0),
          width: recommended ? 1.5 : 1,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 14,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (recommended) ...[
            const AppBadge(
              text: 'Recomendado',
              color: Color(0xFF0F766E),
            ),
            const SizedBox(height: 12),
          ],
          Row(
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: const Color(0xFFE0F2F1),
                child: Text(
                  worker.name.substring(0, 1),
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF0F172A),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      worker.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      worker.specialty,
                      style: const TextStyle(
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
              if (worker.premium)
                const AppBadge(
                  text: 'Premium',
                  color: Color(0xFF7C3AED),
                ),
            ],
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.star,
                    color: Color(0xFFF59E0B),
                    size: 20,
                  ),
                  Text(
                    ' ${worker.rating}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ],
              ),
              if (worker.kycVerified)
                const MiniStatus(
                  icon: Icons.verified_user,
                  text: 'KYC',
                ),
              if (worker.sctrActive)
                const MiniStatus(
                  icon: Icons.health_and_safety,
                  text: 'SCTR',
                ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: const Color(0xFFE2E8F0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Cotización: ${money(amount)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Neto estimado trabajador: ${money(breakdown.workerNet)}',
                  style: const TextStyle(
                    color: Color(0xFF64748B),
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          PrimaryButton(
            label: 'Elegir y proteger pago',
            icon: Icons.lock,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}