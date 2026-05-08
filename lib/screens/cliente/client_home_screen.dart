import 'package:flutter/material.dart';

import '../../widgets/app_badge.dart';
import '../../widgets/tkoh_page.dart';

class ClientHomeScreen extends StatelessWidget {
  const ClientHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TKOHPage(
      title: 'Hola, Vidal',
      subtitle: '¿Qué servicio necesitas hoy?',
      children: [
        const _SearchBox(),
        const SizedBox(height: 18),
        const Text(
          'Categorías populares',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: Color(0xFF0F172A),
          ),
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

class _SearchBox extends StatelessWidget {
  const _SearchBox();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.search,
            color: Color(0xFF64748B),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Buscar: gasfitero, electricista, pintura...',
              style: TextStyle(
                color: Color(0xFF64748B),
              ),
            ),
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
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 14,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: const Color(0xFF0F766E),
            size: 30,
          ),
          const Spacer(),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: const TextStyle(
              color: Color(0xFF64748B),
              fontSize: 12,
            ),
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
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFE0F2F1),
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBadge(
            text: 'Fondos protegidos',
            color: Color(0xFF0F766E),
          ),
          SizedBox(height: 12),
          Text(
            'Reparación de fuga en cocina',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 18,
              color: Color(0xFF0F172A),
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Tu pago está seguro hasta que confirmes que el trabajo se realizó correctamente.',
            style: TextStyle(
              color: Color(0xFF334155),
              height: 1.35,
            ),
          ),
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
        border: Border.all(
          color: const Color(0xFFFDE68A),
        ),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.campaign,
            color: Color(0xFFB45309),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Espacio nativo para publicidad: ferretería, pinturas, herramientas. No interrumpe el flujo de contratación.',
              style: TextStyle(
                color: Color(0xFF78350F),
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}