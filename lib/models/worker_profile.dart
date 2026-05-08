class WorkerProfile {
  final String name;
  final bool premium;
  final bool kycVerified;
  final bool sctrActive;
  final double rating;
  final String specialty;

  const WorkerProfile({
    required this.name,
    required this.premium,
    required this.kycVerified,
    required this.sctrActive,
    required this.rating,
    required this.specialty,
  });
}
