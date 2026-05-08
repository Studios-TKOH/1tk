import 'package:flutter/material.dart';

import '../core/enums.dart';
import '../core/utils.dart';
import '../models/service_request.dart';
import 'app_badge.dart';
import 'mini_status.dart';

class JobCard extends StatelessWidget {
  final ServiceRequest request;
  final bool lockedForBasic;

  const JobCard({
    super.key,
    required this.request,
    required this.lockedForBasic,
  });

  @override
  Widget build(BuildContext context) {
    final isStandard = request.priority == PriorityPlan.estandar;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
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
          Row(
            children: [
              Expanded(
                child: Text(
                  request.title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF0F172A),
                  ),
                ),
              ),
              AppBadge(
                text: isStandard ? 'Estándar' : 'Urgente',
                color: isStandard
                    ? const Color(0xFF64748B)
                    : const Color(0xFFDC2626),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '${request.category} · ${request.address}',
            style: const TextStyle(
              color: Color(0xFF64748B),
              height: 1.35,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            money(request.budget),
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: Color(0xFF0F172A),
            ),
          ),
          if (request.highRisk) ...[
            const SizedBox(height: 8),
            const MiniStatus(
              icon: Icons.health_and_safety,
              text: 'Requiere SCTR',
            ),
          ],
          if (lockedForBasic) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFEF2F2),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFFFECACA),
                ),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.lock_clock,
                    color: Color(0xFFDC2626),
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Bloqueado para plan Básico por 24-48h. Premium lo ve de inmediato.',
                      style: TextStyle(
                        color: Color(0xFFDC2626),
                        fontWeight: FontWeight.w700,
                        height: 1.35,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}