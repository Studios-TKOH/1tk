class PaymentBreakdown {
  final double gross;
  final double taxRetention;
  final double platformFee;
  final double workerNet;
  final bool commissionZeroDisabled;

  const PaymentBreakdown({
    required this.gross,
    required this.taxRetention,
    required this.platformFee,
    required this.workerNet,
    required this.commissionZeroDisabled,
  });
}
