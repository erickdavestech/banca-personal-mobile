import 'package:banca_movil_libs/banca_movil_libs.dart';
import 'package:flutter/material.dart';

class CreditLineCard extends StatelessWidget {
  final Product product;

  const CreditLineCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Encabezado: Icono + Descripción + Número
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    //TODO Cambiar icono por el correcto
                    // Image.asset(AppImages.lineaConstruccion, width: 24),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.description ?? 'Línea de construcción',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Construcción provisional',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  'No. ${product.accountNumber ?? ''}',
                  style: const TextStyle(color: Colors.blueGrey),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Saldo disponible
            Text(
              'Saldo disponible',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            Text(
              'B/. ${product.available ?? '0.00'}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            // Botones
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text('Ver movimientos'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text('Transferir'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
