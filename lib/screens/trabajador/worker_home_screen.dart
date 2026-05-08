import 'package:flutter/material.dart';
import '../../core/enums.dart';
import '../../models/service_request.dart';
import '../../mock/mock_data_sr.dart';
import '../../widgets/shared_widgets.dart';

class WorkerHomeScreen extends StatelessWidget {
  const WorkerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TKOHPage(
      title: 'Trabajos disponibles', subtitle: 'Vista del trabajador: Premium ve alertas inmediatas; Básico recibe retraso.',
      children: const [
        _WorkerPlanBanner(),
        SizedBox(height: 16),
        JobCard(request: mockRequest, lockedForBasic: false),
        SizedBox(height: 14),
        JobCard(
          request: ServiceRequest(
            title: 'Pintar habitación principal', category: 'Pintura', address: 'Surco, Lima', budget: 950,
            highRisk: false, priority: PriorityPlan.estandar, status: ServiceStatus.publicado,
          ),
          lockedForBasic: true,
        ),
      ],
    );
  }
}

class _WorkerPlanBanner extends StatelessWidget {
  const _WorkerPlanBanner();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: const Color(0xFF312E81), borderRadius: BorderRadius.circular(24)),
      child: const Row(children: [Icon(Icons.workspace_premium, color: Colors.white), SizedBox(width: 12), Expanded(child: Text('Premium activo: alertas inmediatas y comisión cero salvo servicios mayores a S/ 1,500.', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, height: 1.35)))]),
    );
  }
}