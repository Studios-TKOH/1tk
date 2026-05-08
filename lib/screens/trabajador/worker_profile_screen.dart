import 'package:flutter/material.dart';

import '../../mock/mock_data_sr.dart';
import '../../models/worker_profile.dart';
import '../../widgets/info_card.dart';
import '../../widgets/mini_status.dart';
import '../../widgets/tkoh_page.dart';

class WorkerProfileScreen extends StatelessWidget {
  const WorkerProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const TKOHPage(
      title: 'Perfil trabajador',
      subtitle: 'Confianza visible para el cliente.',
      children: [
        _ProfileHeader(worker: premiumWorker),
        SizedBox(height: 18),
        InfoCard(
          icon: Icons.star,
          title: 'Reputación',
          subtitle: '4.8/5 · 126 servicios completados',
        ),
        SizedBox(height: 14),
        InfoCard(
          icon: Icons.workspace_premium,
          title: 'Plan Premium',
          subtitle:
              'Sin retraso en alertas y comisión cero en servicios medianos.',
        ),
        SizedBox(height: 14),
        InfoCard(
          icon: Icons.support_agent,
          title: 'Onboarding asistido',
          subtitle:
              'Servicio opcional para que TKOH complete datos y documentos.',
        ),
      ],
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  final WorkerProfile worker;
  const _ProfileHeader({required this.worker});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 34,
                backgroundColor: const Color(0xFFE0F2F1),
                child: Text(
                  worker.name.substring(0, 1),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      worker.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      worker.specialty,
                      style: const TextStyle(color: Color(0xFF64748B)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              MiniStatus(icon: Icons.verified_user, text: 'Identidad validada'),
              MiniStatus(icon: Icons.health_and_safety, text: 'SCTR vigente'),
              MiniStatus(icon: Icons.workspace_premium, text: 'Premium'),
            ],
          ),
        ],
      ),
    );
  }
}
