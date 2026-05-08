import 'package:flutter/material.dart';
import '../../core/enums.dart';
import '../../core/utils.dart';
import '../../widgets/shared_widgets.dart';
import '../../widgets/app_dialogs.dart';

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
          onPressed: () => AppDialogs.showPublishedDialog(context),
        ),
      ],
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
