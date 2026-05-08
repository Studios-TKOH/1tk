import 'package:flutter/material.dart';

import '../../mock/mock_data_sr.dart';
import '../../widgets/tkoh_page.dart';
import '../../widgets/worker_quote_card.dart';

class QuotesScreen extends StatelessWidget {
  const QuotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TKOHPage(
      title: 'Cotizaciones',
      subtitle: 'Compara reputación, verificación y disponibilidad.',
      children: [
        WorkerQuoteCard(
          worker: premiumWorker,
          amount: 1850,
          recommended: true,
        ),
        const SizedBox(height: 14),
        WorkerQuoteCard(
          worker: basicWorker,
          amount: 1680,
          recommended: false,
        ),
      ],
    );
  }
}