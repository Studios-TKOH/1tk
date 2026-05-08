import 'package:flutter/material.dart';

void main() {
  runApp(const TKOHApp());
}

class TKOHApp extends StatelessWidget {
  const TKOHApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UnToque TKOH',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0F766E),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF7FAFC),
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          backgroundColor: Color(0xFFF7FAFC),
          elevation: 0,
        ),
      ),
      home: const RoleSelectionScreen(),
    );
  }
}

enum UserRole { cliente, trabajador }

enum PriorityPlan { estandar, urgente, muyUrgente }

enum ServiceStatus {
  publicado,
  cotizado,
  fondosProtegidos,
  enEjecucion,
  completado,
  liquidacionPendiente,
}

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

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: const Color(0xFF0F766E),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.handyman,
                  color: Colors.white,
                  size: 34,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'UnToque TKOH',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Servicios del hogar con identidad verificada, pago protegido y liquidación transparente.',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF64748B),
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 32),
              _RoleCard(
                icon: Icons.home_repair_service_outlined,
                title: 'Entrar como cliente',
                subtitle:
                    'Publica un servicio, compara cotizaciones y protege tu pago en bóveda.',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const MainShell(role: UserRole.cliente),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _RoleCard(
                icon: Icons.engineering_outlined,
                title: 'Entrar como trabajador',
                subtitle:
                    'Completa KYC, recibe trabajos y revisa tus liquidaciones.',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const MainShell(role: UserRole.trabajador),
                  ),
                ),
              ),
              const Spacer(),
              const _TrustStrip(),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _RoleCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0F000000),
              blurRadius: 18,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: const Color(0xFFE0F2F1),
              child: Icon(icon, color: const Color(0xFF0F766E), size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Color(0xFF64748B),
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Color(0xFF94A3B8)),
          ],
        ),
      ),
    );
  }
}

class MainShell extends StatefulWidget {
  final UserRole role;
  const MainShell({super.key, required this.role});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final isClient = widget.role == UserRole.cliente;
    final pages = isClient
        ? const [
            ClientHomeScreen(),
            CreateServiceScreen(),
            QuotesScreen(),
            ProtectedPaymentScreen(),
          ]
        : const [
            WorkerHomeScreen(),
            WorkerKycScreen(),
            WorkerEarningsScreen(),
            WorkerProfileScreen(),
          ];

    final items = isClient
        ? const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Inicio',
            ),
            NavigationDestination(
              icon: Icon(Icons.add_circle_outline),
              selectedIcon: Icon(Icons.add_circle),
              label: 'Publicar',
            ),
            NavigationDestination(
              icon: Icon(Icons.groups_outlined),
              selectedIcon: Icon(Icons.groups),
              label: 'Cotizaciones',
            ),
            NavigationDestination(
              icon: Icon(Icons.lock_outline),
              selectedIcon: Icon(Icons.lock),
              label: 'Pago',
            ),
          ]
        : const [
            NavigationDestination(
              icon: Icon(Icons.work_outline),
              selectedIcon: Icon(Icons.work),
              label: 'Trabajos',
            ),
            NavigationDestination(
              icon: Icon(Icons.verified_user_outlined),
              selectedIcon: Icon(Icons.verified_user),
              label: 'KYC',
            ),
            NavigationDestination(
              icon: Icon(Icons.account_balance_wallet_outlined),
              selectedIcon: Icon(Icons.account_balance_wallet),
              label: 'Ganancias',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: 'Perfil',
            ),
          ];

    return Scaffold(
      body: pages[index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (value) => setState(() => index = value),
        destinations: items,
      ),
    );
  }
}

class ClientHomeScreen extends StatelessWidget {
  const ClientHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TKOHPage(
      title: 'Hola, Vidal',
      subtitle: '¿Qué necesitas resolver hoy?',
      children: [
        const _SearchBox(),
        const SizedBox(height: 18),
        const Text(
          'Categorías frecuentes',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 12),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.32,
          children: const [
            _CategoryCard(
              icon: Icons.plumbing,
              title: 'Gasfitería',
              subtitle: 'Fugas, tuberías',
            ),
            _CategoryCard(
              icon: Icons.electrical_services,
              title: 'Electricidad',
              subtitle: 'Luces, tomas',
            ),
            _CategoryCard(
              icon: Icons.format_paint,
              title: 'Pintura',
              subtitle: 'Habitaciones',
            ),
            _CategoryCard(
              icon: Icons.cleaning_services,
              title: 'Limpieza',
              subtitle: 'Hogar y oficinas',
            ),
          ],
        ),
        const SizedBox(height: 18),
        const _CurrentServiceCard(),
        const SizedBox(height: 18),
        const _NativeAdMock(),
      ],
    );
  }
}

class CreateServiceScreen extends StatefulWidget {
  const CreateServiceScreen({super.key});

  @override
  State<CreateServiceScreen> createState() => _CreateServiceScreenState();
}

class _CreateServiceScreenState extends State<CreateServiceScreen> {
  PriorityPlan selectedPlan = PriorityPlan.estandar;
  bool highRisk = false;
  double budget = 1850;

  @override
  Widget build(BuildContext context) {
    return TKOHPage(
      title: 'Publicar servicio',
      subtitle: 'Simulación del flujo cliente para crear una solicitud.',
      children: [
        const _InputPreview(
          label: 'Problema',
          value: 'Fuga debajo del lavadero de cocina',
        ),
        const SizedBox(height: 12),
        const _InputPreview(
          label: 'Ubicación',
          value: 'Miraflores, Lima · coordenadas confirmadas',
        ),
        const SizedBox(height: 12),
        _SwitchCard(
          title: 'Trabajo de alto riesgo',
          subtitle:
              'Si está activo, solo podrán postular trabajadores con SCTR vigente.',
          value: highRisk,
          onChanged: (value) => setState(() => highRisk = value),
        ),
        const SizedBox(height: 16),
        Text(
          'Presupuesto estimado: ${money(budget)}',
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
        Slider(
          value: budget,
          min: 100,
          max: 3000,
          divisions: 29,
          label: money(budget),
          onChanged: (value) => setState(() => budget = value),
        ),
        const SizedBox(height: 16),
        const Text(
          'Plan de prioridad',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 12),
        _PrioritySelector(
          selected: selectedPlan,
          onChanged: (value) => setState(() => selectedPlan = value),
        ),
        const SizedBox(height: 18),
        PrimaryButton(
          label: 'Publicar solicitud protegida',
          icon: Icons.send,
          onPressed: () => _showPublishedDialog(context),
        ),
      ],
    );
  }
}

class QuotesScreen extends StatelessWidget {
  const QuotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TKOHPage(
      title: 'Cotizaciones',
      subtitle: 'Compara reputación, verificación y disponibilidad.',
      children: [
        WorkerQuoteCard(worker: premiumWorker, amount: 1850, recommended: true),
        const SizedBox(height: 14),
        WorkerQuoteCard(worker: basicWorker, amount: 1680, recommended: false),
      ],
    );
  }
}

class ProtectedPaymentScreen extends StatelessWidget {
  const ProtectedPaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final breakdown = calculatePayment(
      amount: mockRequest.budget,
      isPremiumWorker: premiumWorker.premium,
    );

    return TKOHPage(
      title: 'Bóveda TKOH',
      subtitle:
          'El pago queda protegido hasta que ambas partes cierren el servicio.',
      children: [
        const _StatusTimeline(),
        const SizedBox(height: 18),
        PaymentBreakdownCard(breakdown: breakdown),
        const SizedBox(height: 18),
        PrimaryButton(
          label: 'Confirmar servicio completado',
          icon: Icons.check_circle,
          onPressed: () => _showRatingDialog(context),
        ),
      ],
    );
  }
}

class WorkerHomeScreen extends StatelessWidget {
  const WorkerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TKOHPage(
      title: 'Trabajos disponibles',
      subtitle:
          'Vista del trabajador: Premium ve alertas inmediatas; Básico recibe retraso.',
      children: const [
        _WorkerPlanBanner(),
        SizedBox(height: 16),
        JobCard(request: mockRequest, lockedForBasic: false),
        SizedBox(height: 14),
        JobCard(
          request: ServiceRequest(
            title: 'Pintar habitación principal',
            category: 'Pintura',
            address: 'Surco, Lima',
            budget: 950,
            highRisk: false,
            priority: PriorityPlan.estandar,
            status: ServiceStatus.publicado,
          ),
          lockedForBasic: true,
        ),
      ],
    );
  }
}

class WorkerKycScreen extends StatelessWidget {
  const WorkerKycScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TKOHPage(
      title: 'Verificación KYC',
      subtitle: 'Prototipo visual del onboarding biométrico y documental.',
      children: [
        const _KycStep(number: 1, title: 'DNI frontal y posterior', done: true),
        const _KycStep(
          number: 2,
          title: 'Selfie con prueba de vida',
          done: true,
        ),
        const _KycStep(
          number: 3,
          title: 'Antecedentes y validación interna',
          done: false,
        ),
        const _KycStep(
          number: 4,
          title: 'SCTR para trabajos de alto riesgo',
          done: false,
        ),
        const SizedBox(height: 18),
        PrimaryButton(
          label: 'Simular análisis biométrico',
          icon: Icons.face_retouching_natural,
          onPressed: () => _showKycDialog(context),
        ),
      ],
    );
  }
}

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
        InfoCard(
          icon: Icons.schedule,
          title: 'Liquidación nocturna',
          subtitle:
              'Estado actual: aprobado para liquidación. Simulación de Cron Job a las 23:59.',
        ),
        const SizedBox(height: 14),
        InfoCard(
          icon: Icons.account_balance,
          title: 'Cuenta destino',
          subtitle:
              'BCP **** 8241 · transferencia pendiente de cierre antifraude.',
        ),
      ],
    );
  }
}

class WorkerProfileScreen extends StatelessWidget {
  const WorkerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TKOHPage(
      title: 'Perfil trabajador',
      subtitle: 'Confianza visible para el cliente.',
      children: const [
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

class TKOHPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Widget> children;

  const TKOHPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 22, 20, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.7,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Color(0xFF64748B),
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            sliver: SliverList(delegate: SliverChildListDelegate(children)),
          ),
        ],
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const InfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFFE0F2F1),
            child: Icon(icon, color: const Color(0xFF0F766E)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF64748B),
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentBreakdownCard extends StatelessWidget {
  final PaymentBreakdown breakdown;

  const PaymentBreakdownCard({super.key, required this.breakdown});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(26),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.lock, color: Colors.white),
              SizedBox(width: 8),
              Text(
                'Desglose protegido',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _PaymentRow(label: 'Monto bruto', value: money(breakdown.gross)),
          _PaymentRow(
            label: 'Retención SUNAT 8%',
            value: '- ${money(breakdown.taxRetention)}',
          ),
          _PaymentRow(
            label: 'Comisión TKOH 5%',
            value: '- ${money(breakdown.platformFee)}',
          ),
          const Divider(color: Color(0xFF334155), height: 28),
          _PaymentRow(
            label: 'Neto trabajador',
            value: money(breakdown.workerNet),
            strong: true,
          ),
          if (breakdown.commissionZeroDisabled) ...[
            const SizedBox(height: 12),
            const Text(
              'Aviso: beneficio Premium de comisión cero desactivado porque el servicio supera S/ 1,500.',
              style: TextStyle(color: Color(0xFFFDE68A), height: 1.35),
            ),
          ],
        ],
      ),
    );
  }
}

class _PaymentRow extends StatelessWidget {
  final String label;
  final String value;
  final bool strong;

  const _PaymentRow({
    required this.label,
    required this.value,
    this.strong = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: strong ? Colors.white : const Color(0xFFCBD5E1),
              fontWeight: strong ? FontWeight.w900 : FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontWeight: strong ? FontWeight.w900 : FontWeight.w700,
              fontSize: strong ? 18 : 14,
            ),
          ),
        ],
      ),
    );
  }
}

class WorkerQuoteCard extends StatelessWidget {
  final WorkerProfile worker;
  final double amount;
  final bool recommended;

  const WorkerQuoteCard({
    super.key,
    required this.worker,
    required this.amount,
    required this.recommended,
  });

  @override
  Widget build(BuildContext context) {
    final breakdown = calculatePayment(
      amount: amount,
      isPremiumWorker: worker.premium,
    );

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: recommended
              ? const Color(0xFF0F766E)
              : const Color(0xFFE2E8F0),
          width: recommended ? 1.5 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: const Color(0xFFE0F2F1),
                child: Text(
                  worker.name.substring(0, 1),
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      worker.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      worker.specialty,
                      style: const TextStyle(color: Color(0xFF64748B)),
                    ),
                  ],
                ),
              ),
              if (worker.premium)
                const _Badge(text: 'Premium', color: Color(0xFF7C3AED)),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              const Icon(Icons.star, color: Color(0xFFF59E0B), size: 20),
              Text(' ${worker.rating}'),
              const SizedBox(width: 12),
              if (worker.kycVerified)
                const _MiniStatus(icon: Icons.verified_user, text: 'KYC'),
              const SizedBox(width: 8),
              if (worker.sctrActive)
                const _MiniStatus(icon: Icons.health_and_safety, text: 'SCTR'),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            'Cotización: ${money(amount)}',
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
          ),
          Text(
            'Neto estimado trabajador: ${money(breakdown.workerNet)}',
            style: const TextStyle(color: Color(0xFF64748B)),
          ),
          const SizedBox(height: 14),
          PrimaryButton(
            label: 'Elegir y proteger pago',
            icon: Icons.lock,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class JobCard extends StatelessWidget {
  final ServiceRequest request;
  final bool lockedForBasic;

  const JobCard({
    super.key,
    required this.request,
    required this.lockedForBasic,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
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
              Expanded(
                child: Text(
                  request.title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              _Badge(
                text: request.priority == PriorityPlan.estandar
                    ? 'Estándar'
                    : 'Urgente',
                color: request.priority == PriorityPlan.estandar
                    ? const Color(0xFF64748B)
                    : const Color(0xFFDC2626),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '${request.category} · ${request.address}',
            style: const TextStyle(color: Color(0xFF64748B)),
          ),
          const SizedBox(height: 12),
          Text(
            money(request.budget),
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
          ),
          if (request.highRisk)
            const Padding(
              padding: EdgeInsets.only(top: 8),
              child: _MiniStatus(
                icon: Icons.health_and_safety,
                text: 'Requiere SCTR',
              ),
            ),
          if (lockedForBasic) ...[
            const SizedBox(height: 12),
            const Text(
              'Bloqueado para plan Básico por 24-48h. Premium lo ve de inmediato.',
              style: TextStyle(
                color: Color(0xFFDC2626),
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _SearchBox extends StatelessWidget {
  const _SearchBox();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: const Row(
        children: [
          Icon(Icons.search, color: Color(0xFF64748B)),
          SizedBox(width: 10),
          Text(
            'Buscar: gasfitero, electricista, pintura...',
            style: TextStyle(color: Color(0xFF64748B)),
          ),
        ],
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _CategoryCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFF0F766E), size: 30),
          const Spacer(),
          Text(title, style: const TextStyle(fontWeight: FontWeight.w900)),
          Text(
            subtitle,
            style: const TextStyle(color: Color(0xFF64748B), fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _CurrentServiceCard extends StatelessWidget {
  const _CurrentServiceCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFE0F2F1),
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Badge(text: 'Fondos protegidos', color: Color(0xFF0F766E)),
          SizedBox(height: 12),
          Text(
            'Reparación de fuga en cocina',
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
          ),
          SizedBox(height: 4),
          Text('Pago asegurado en bóveda TKOH. Pendiente de ejecución.'),
        ],
      ),
    );
  }
}

class _NativeAdMock extends StatelessWidget {
  const _NativeAdMock();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEB),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFFDE68A)),
      ),
      child: const Row(
        children: [
          Icon(Icons.campaign, color: Color(0xFFB45309)),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Espacio nativo para publicidad: ferretería, pinturas, herramientas. No interrumpe el flujo de contratación.',
            ),
          ),
        ],
      ),
    );
  }
}

class _InputPreview extends StatelessWidget {
  final String label;
  final String value;

  const _InputPreview({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF64748B),
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

class _SwitchCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SwitchCard({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(color: Color(0xFF64748B)),
                ),
              ],
            ),
          ),
          Switch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}

class _PrioritySelector extends StatelessWidget {
  final PriorityPlan selected;
  final ValueChanged<PriorityPlan> onChanged;

  const _PrioritySelector({required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<PriorityPlan>(
      segments: const [
        ButtonSegment(value: PriorityPlan.estandar, label: Text('Estándar')),
        ButtonSegment(value: PriorityPlan.urgente, label: Text('Urgente')),
        ButtonSegment(
          value: PriorityPlan.muyUrgente,
          label: Text('Muy urgente'),
        ),
      ],
      selected: {selected},
      onSelectionChanged: (value) => onChanged(value.first),
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

class _WorkerPlanBanner extends StatelessWidget {
  const _WorkerPlanBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF312E81),
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Row(
        children: [
          Icon(Icons.workspace_premium, color: Colors.white),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Premium activo: alertas inmediatas y comisión cero salvo servicios mayores a S/ 1,500.',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _KycStep extends StatelessWidget {
  final int number;
  final String title;
  final bool done;

  const _KycStep({
    required this.number,
    required this.title,
    required this.done,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: done
                  ? const Color(0xFFDCFCE7)
                  : const Color(0xFFF1F5F9),
              child: done
                  ? const Icon(Icons.check, color: Color(0xFF15803D))
                  : Text('$number'),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.w800),
              ),
            ),
          ],
        ),
      ),
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
              _MiniStatus(
                icon: Icons.verified_user,
                text: 'Identidad validada',
              ),
              _MiniStatus(icon: Icons.health_and_safety, text: 'SCTR vigente'),
              _MiniStatus(icon: Icons.workspace_premium, text: 'Premium'),
            ],
          ),
        ],
      ),
    );
  }
}

class _TrustStrip extends StatelessWidget {
  const _TrustStrip();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _TinyTrust(icon: Icons.verified_user, text: 'KYC'),
        _TinyTrust(icon: Icons.lock, text: 'Escrow'),
        _TinyTrust(icon: Icons.receipt_long, text: 'SUNAT'),
        _TinyTrust(icon: Icons.star, text: 'Reputación'),
      ],
    );
  }
}

class _TinyTrust extends StatelessWidget {
  final IconData icon;
  final String text;

  const _TinyTrust({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFF0F766E)),
        const SizedBox(height: 4),
        Text(
          text,
          style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
        ),
      ],
    );
  }
}

class _Badge extends StatelessWidget {
  final String text;
  final Color color;

  const _Badge({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(99),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w900,
          fontSize: 12,
        ),
      ),
    );
  }
}

class _MiniStatus extends StatelessWidget {
  final IconData icon;
  final String text;

  const _MiniStatus({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(99),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: const Color(0xFF0F766E)),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}

void _showPublishedDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('Solicitud publicada'),
      content: const Text(
        'Se enviará a trabajadores cercanos. Si el plan es urgente, se prioriza la alerta.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Entendido'),
        ),
      ],
    ),
  );
}

void _showKycDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('KYC simulado'),
      content: const Text(
        'En producción aquí se conectaría cámara, OCR de DNI y validación biométrica.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cerrar'),
        ),
      ],
    ),
  );
}

void _showRatingDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('Califica el servicio'),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.star, color: Color(0xFFF59E0B)),
              Icon(Icons.star, color: Color(0xFFF59E0B)),
              Icon(Icons.star, color: Color(0xFFF59E0B)),
              Icon(Icons.star, color: Color(0xFFF59E0B)),
              Icon(Icons.star_half, color: Color(0xFFF59E0B)),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'Luego de calificar, la operación pasa a liquidación pendiente.',
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Enviar'),
        ),
      ],
    ),
  );
}
