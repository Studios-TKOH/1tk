import 'package:flutter/material.dart';
import '../cliente/client_home_screen.dart';
import '../trabajador/worker_home_screen.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.handyman, size: 80, color: Color(0xFF0F766E)),
              const SizedBox(height: 24),
              const Text(
                'Bienvenido a 1TK!',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const Text(
                'Selecciona cómo deseas ingresar',
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              _buildRoleCard(
                context,
                title: 'Soy Cliente',
                subtitle: 'Necesito un servicio para mi hogar',
                icon: Icons.person_outline,
                color: const Color(0xFF0F766E),
                onTap: () {
                  // Navegar a ClientHomeScreen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const ClientHomeScreen()),
                  );
                },
              ),
              const SizedBox(height: 16),
              _buildRoleCard(
                context,
                title: 'Soy Trabajador',
                subtitle: 'Quiero ofrecer mis servicios',
                icon: Icons.work_outline,
                color: const Color(0xFFD97706),
                onTap: () {
                  // Navegar a WorkerHomeScreen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const WorkerHomeScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          border: Border.all(color: color.withOpacity(0.3), width: 2),
          borderRadius: BorderRadius.circular(16),
          color: color.withOpacity(0.05),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  Text(subtitle, style: TextStyle(color: Colors.grey.shade600)),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: color),
          ],
        ),
      ),
    );
  }
}
