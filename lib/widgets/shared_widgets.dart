import 'package:flutter/material.dart';
import '../core/enums.dart';
import '../core/utils.dart';
import '../models/payment_breakdown.dart';
import '../models/worker_profile.dart';
import '../models/service_request.dart';

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
                const CustomBadge(text: 'Premium', color: Color(0xFF7C3AED)),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              const Icon(Icons.star, color: Color(0xFFF59E0B), size: 20),
              Text(' ${worker.rating}'),
              const SizedBox(width: 12),
              if (worker.kycVerified)
                const MiniStatus(icon: Icons.verified_user, text: 'KYC'),
              const SizedBox(width: 8),
              if (worker.sctrActive)
                const MiniStatus(icon: Icons.health_and_safety, text: 'SCTR'),
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
              CustomBadge(
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
              child: MiniStatus(
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

class CustomBadge extends StatelessWidget {
  final String text;
  final Color color;
  const CustomBadge({super.key, required this.text, required this.color});

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

class MiniStatus extends StatelessWidget {
  final IconData icon;
  final String text;
  const MiniStatus({super.key, required this.icon, required this.text});

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
