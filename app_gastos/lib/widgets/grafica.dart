import 'package:flutter/material.dart';
import 'package:app_gastos/models/gasto.dart';

class Grafica extends StatelessWidget {
  const Grafica({super.key, required this.gastos});

  final List<Gasto> gastos;

  // Agrupamos los gastos por categoría para calcular la altura de las barras
  double get totalGastos {
    return gastos.fold(0, (sum, item) => sum + item.cantidad);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
            Theme.of(context).colorScheme.primary.withOpacity(0.0),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: Categoria.values.map((cat) {
          final totalPorCat = gastos
              .where((g) => g.categoria == cat)
              .fold(0.0, (sum, item) => sum + item.cantidad);
          
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: FractionallySizedBox(
                      heightFactor: totalGastos == 0 ? 0 : totalPorCat / totalGastos,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                          color: Theme.of(context).colorScheme.primary.withOpacity(0.65),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Icon(iconosCategoria[cat], color: Theme.of(context).colorScheme.primary),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}