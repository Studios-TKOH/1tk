import 'package:flutter/material.dart';
import '../../widgets/shared_widgets.dart';
import '../../widgets/app_dialogs.dart';

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
          onPressed: () => AppDialogs.showKycDialog(context),
        ),
      ],
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
