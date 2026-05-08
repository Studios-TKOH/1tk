// Archivo: lib/screens/main_shell.dart
import 'package:flutter/material.dart';
import '../core/enums.dart';

// Importaciones individuales del Cliente
import 'cliente/client_home_screen.dart';
import 'cliente/create_service_screen.dart';
import 'cliente/quotes_screen.dart';
import 'cliente/protected_payment_screen.dart';

// Importaciones individuales del Trabajador
import 'trabajador/worker_home_screen.dart';
import 'trabajador/worker_kyc_screen.dart';
import 'trabajador/worker_earnings_screen.dart';
import 'trabajador/worker_profile_screen.dart';

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

    // Las páginas se cargan desde los archivos individuales
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
