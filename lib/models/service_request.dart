import '../core/enums.dart';

class ServiceRequest {
  final String title;
  final String category;
  final String address;
  final double budget;
  final bool highRisk;
  final PriorityPlan priority;
  final ServiceStatus status;

  const ServiceRequest({
    required this.title,
    required this.category,
    required this.address,
    required this.budget,
    required this.highRisk,
    required this.priority,
    required this.status,
  });
}
