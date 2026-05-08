import 'package:flutter/material.dart';

import '../../../core/enums.dart';

class PrioritySelector extends StatelessWidget {
  final PriorityPlan selected;
  final ValueChanged<PriorityPlan> onChanged;

  const PrioritySelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<PriorityPlan>(
      segments: const [
        ButtonSegment(
          value: PriorityPlan.estandar,
          label: Text('Estándar'),
          icon: Icon(Icons.schedule),
        ),
        ButtonSegment(
          value: PriorityPlan.urgente,
          label: Text('Urgente'),
          icon: Icon(Icons.bolt),
        ),
        ButtonSegment(
          value: PriorityPlan.muyUrgente,
          label: Text('Muy urgente'),
          icon: Icon(Icons.priority_high),
        ),
      ],
      selected: {selected},
      onSelectionChanged: (value) => onChanged(value.first),
    );
  }
}