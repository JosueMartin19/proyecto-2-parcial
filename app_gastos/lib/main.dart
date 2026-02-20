import 'package:flutter/material.dart';
import 'package:app_gastos/models/gasto.dart';
import 'package:app_gastos/widgets/nuevo_gasto.dart';
import 'package:app_gastos/widgets/grafica.dart';

void main() => runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: PantallaGastos()));

class PantallaGastos extends StatefulWidget {
  const PantallaGastos({super.key});
  @override
  State<PantallaGastos> createState() => _PantallaGastosState();
}

class _PantallaGastosState extends State<PantallaGastos> {
  // Esta es la fuente de verdad de tu aplicación
  final List<Gasto> _gastos = [];

  void _abrirModal() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NuevoGasto(
        onAddGasto: (gasto) => setState(() => _gastos.add(gasto)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Requisito: Detectar giro del equipo para reacomodar elementos
    final esPaisaje = MediaQuery.of(context).orientation == Orientation.landscape;

    // Requisito: Lista con desplazamiento (scroll)
    Widget lista = _gastos.isEmpty 
      ? const Center(child: Text('No hay gastos.'))
      : ListView.builder(
          itemCount: _gastos.length,
          itemBuilder: (ctx, i) => Card(
            child: ListTile(
              leading: Icon(iconosCategoria[_gastos[i].categoria]),
              title: Text(_gastos[i].titulo),
              subtitle: Text('\$${_gastos[i].cantidad.toStringAsFixed(2)}'),
              trailing: Text('${_gastos[i].fecha.day}/${_gastos[i].fecha.month}/${_gastos[i].fecha.year}'),
            ),
          ),
        );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Control Gastos Flutter'), 
        actions: [
          IconButton(onPressed: _abrirModal, icon: const Icon(Icons.add))
        ],
      ),
      // REACOMPODO DINÁMICO: Cambia entre Row y Column según la orientación
      body: esPaisaje 
        ? Row(
            children: [
              // Ahora pasamos la lista real a la Gráfica
              Expanded(child: Grafica(gastos: _gastos)), 
              Expanded(child: lista),
            ],
          )
        : Column(
            children: [
              // La gráfica se dibuja arriba en modo vertical
              SizedBox(
                height: 200, 
                child: Grafica(gastos: _gastos),
              ), 
              Expanded(child: lista),
            ],
          ),
    );
  }
} 