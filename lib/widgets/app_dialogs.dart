import 'package:flutter/material.dart';

class AppDialogs {
  static void showPublishedDialog(BuildContext context) {
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

  static void showKycDialog(BuildContext context) {
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

  static void showRatingDialog(BuildContext context) {
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
}
