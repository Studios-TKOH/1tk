import 'package:flutter/material.dart';

import '../../core/enums.dart';
import '../../widgets/app_button.dart';
import '../../widgets/app_dialogs.dart';
import '../../widgets/tkoh_page.dart';
import 'create_service/budget_card.dart';
import 'create_service/input_preview.dart';
import 'create_service/priority_selector.dart';
import 'create_service/switch_card.dart';

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
        const InputPreview(
          icon: Icons.build_circle_outlined,
          label: 'Problema',
          value: 'Fuga debajo del lavadero de cocina',
        ),
        const SizedBox(height: 12),
        const InputPreview(
          icon: Icons.location_on_outlined,
          label: 'Ubicación',
          value: 'Miraflores, Lima · coordenadas confirmadas',
        ),
        const SizedBox(height: 12),
        SwitchCard(
          title: 'Trabajo de alto riesgo',
          subtitle:
              'Si está activo, solo podrán postular trabajadores con SCTR vigente.',
          value: highRisk,
          onChanged: (value) => setState(() => highRisk = value),
        ),
        const SizedBox(height: 18),
        BudgetCard(
          budget: budget,
          onChanged: (value) => setState(() => budget = value),
        ),
        const SizedBox(height: 18),
        const Text(
          'Plan de prioridad',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 12),
        PrioritySelector(
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