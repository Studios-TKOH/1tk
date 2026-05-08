import '../models/payment_breakdown.dart';

PaymentBreakdown calculatePayment({
  required double amount,
  required bool isPremiumWorker,
}) {
  final taxRetention = amount > 1500 ? amount * 0.08 : 0.0;
  final commissionZeroDisabled = isPremiumWorker && amount > 1500;
  final platformFee = isPremiumWorker && !commissionZeroDisabled
      ? 0.0
      : amount * 0.05;

  return PaymentBreakdown(
    gross: amount,
    taxRetention: taxRetention,
    platformFee: platformFee,
    workerNet: amount - taxRetention - platformFee,
    commissionZeroDisabled: commissionZeroDisabled,
  );
}

String money(double value) => 'S/ ${value.toStringAsFixed(2)}';
