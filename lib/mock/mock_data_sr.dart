import '../core/enums.dart';
import '../models/service_request.dart';
import '../models/worker_profile.dart';

const mockRequest = ServiceRequest(
  title: 'Reparación de fuga en cocina',
  category: 'Gasfitería',
  address: 'Miraflores, Lima',
  budget: 1850,
  highRisk: false,
  priority: PriorityPlan.urgente,
  status: ServiceStatus.fondosProtegidos,
);

const premiumWorker = WorkerProfile(
  name: 'Carlos Rojas',
  premium: true,
  kycVerified: true,
  sctrActive: true,
  rating: 4.8,
  specialty: 'Gasfitería y humedad',
);

const basicWorker = WorkerProfile(
  name: 'Miguel Torres',
  premium: false,
  kycVerified: true,
  sctrActive: false,
  rating: 4.4,
  specialty: 'Mantenimiento general',
);

// --- Listas de datos para poblar el Home ---

class MockData {
  static final List<ServiceRequest> recentRequests = [
    const ServiceRequest(
      title: 'Fuga de agua en tubería principal',
      category: 'Gasfitería',
      address: 'Miraflores, Lima',
      budget: 120.0,
      highRisk: false,
      priority: PriorityPlan.estandar,
      status: ServiceStatus.publicado,
    ),
    const ServiceRequest(
      title: 'Instalación de tablero eléctrico',
      category: 'Electricidad',
      address: 'San Isidro, Lima',
      budget: 1800.0, // Monto mayor a 1500 para probar la SUNAT
      highRisk: true,
      priority: PriorityPlan.urgente,
      status: ServiceStatus.cotizado,
    ),
  ];

  static final List<ServiceRequest> availableJobs = [
    const ServiceRequest(
      title: 'Reparación de fachada',
      category: 'Albañilería',
      address: 'Surco, Lima',
      budget: 2500.0,
      highRisk: true, // Requiere SCTR
      priority: PriorityPlan.muyUrgente,
      status: ServiceStatus.publicado,
    ),
    const ServiceRequest(
      title: 'Mantenimiento de terma',
      category: 'Gasfitería',
      address: 'Lince, Lima',
      budget: 80.0,
      highRisk: false,
      priority: PriorityPlan.estandar,
      status: ServiceStatus.publicado,
    ),
  ];
}
