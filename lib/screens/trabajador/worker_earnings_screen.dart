import 'package:flutter/material.dart';

import '../../core/utils.dart';
import '../../mock/mock_data_sr.dart';
import '../../widgets/info_card.dart';
import '../../widgets/payment_breakdown_card.dart';
import '../../widgets/tkoh_page.dart';

class WorkerEarningsScreen extends StatelessWidget {
  const WorkerEarningsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final breakdown = calculatePayment(
      amount: mockRequest.budget,
      isPremiumWorker: true,
    );
    return TKOHPage(
      title: 'Ganancias',
      subtitle: 'Liquidación estimada después de retenciones y comisión.',
      children: [
        PaymentBreakdownCard(breakdown: breakdown),
        const SizedBox(height: 18),
        const InfoCard(
          icon: Icons.schedule,
          title: 'Liquidación nocturna',
          subtitle:
              'Estado actual: aprobado para liquidación. Simulación de Cron Job a las 23:59.',
        ),
        const SizedBox(height: 14),
        const InfoCard(
          icon: Icons.account_balance,
          title: 'Cuenta destino',
          subtitle:
              'BCP **** 8241 · transferencia pendiente de cierre antifraude.',
        ),
      ],
    );
  }
}
