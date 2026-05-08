import 'package:flutter/material.dart';

import '../../core/utils.dart';
import '../../mock/mock_data_sr.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_dialogs.dart';
import '../../widgets/info_card.dart';
import '../../widgets/payment_breakdown_card.dart';
import '../../widgets/tkoh_page.dart';

class ProtectedPaymentScreen extends StatelessWidget {
  const ProtectedPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final breakdown = calculatePayment(
      amount: mockRequest.budget,
      isPremiumWorker: premiumWorker.premium,
    );

    return TKOHPage(
      title: 'Bóveda de pago protegida',
      subtitle:
          'El dinero del cliente está seguro hasta que ambas partes confirmen la finalización.',
      children: [
        const _StatusTimeline(),
        const SizedBox(height: 18),
        PaymentBreakdownCard(breakdown: breakdown),
        const SizedBox(height: 18),
        PrimaryButton(
          label: 'Confirmar servicio completado',
          icon: Icons.check_circle,
          onPressed: () => AppDialogs.showRatingDialog(context),
        ),
      ],
    );
  }
}

class _StatusTimeline extends StatelessWidget {
  const _StatusTimeline();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        InfoCard(
          icon: Icons.credit_card,
          title: '1. Pago autorizado',
          subtitle: 'El cliente autorizó el monto total del servicio.',
        ),
        SizedBox(height: 12),
        InfoCard(
          icon: Icons.lock,
          title: '2. Fondos protegidos',
          subtitle: 'El dinero queda retenido en bóveda virtual.',
        ),
        SizedBox(height: 12),
        InfoCard(
          icon: Icons.done_all,
          title: '3. Cierre bidireccional',
          subtitle: 'Cliente y trabajador confirman la finalización.',
        ),
        SizedBox(height: 12),
        InfoCard(
          icon: Icons.nightlight,
          title: '4. Liquidación 23:59',
          subtitle: 'Se simula split payment y depósito al trabajador.',
        ),
      ],
    );
  }
}