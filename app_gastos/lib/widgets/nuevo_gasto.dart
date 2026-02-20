import 'package:flutter/material.dart';
import 'package:app_gastos/models/gasto.dart';

class NuevoGasto extends StatefulWidget {
  const NuevoGasto({super.key, required this.onAddGasto});
  final void Function(Gasto gasto) onAddGasto;

  @override
  State<NuevoGasto> createState() => _NuevoGastoState();
}

class _NuevoGastoState extends State<NuevoGasto> {
  final _tituloController = TextEditingController();
  final _cantidadController = TextEditingController();
  DateTime? _fechaSeleccionada;
  Categoria _categoriaSeleccionada = Categoria.comida;

  void _presentarDatePicker() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 1),
      lastDate: now,
    );
    setState(() => _fechaSeleccionada = pickedDate);
  }

  void _enviarDatosGasto() {
    final cantidadIngresada = double.tryParse(_cantidadController.text);
    if (_tituloController.text.trim().isEmpty || cantidadIngresada == null || _fechaSeleccionada == null) {
      return;
    }
    widget.onAddGasto(Gasto(
      titulo: _tituloController.text,
      cantidad: cantidadIngresada,
      fecha: _fechaSeleccionada!,
      categoria: _categoriaSeleccionada,
    ));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 48, 16, MediaQuery.of(context).viewInsets.bottom + 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _tituloController,
            maxLength: 50,
            decoration: const InputDecoration(labelText: 'Titulo'),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _cantidadController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(prefixText: '\$ ', labelText: 'Cantidad'),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(_fechaSeleccionada == null ? 'Fecha No Elegida' : '${_fechaSeleccionada!.day}/${_fechaSeleccionada!.month}/${_fechaSeleccionada!.year}'),
                    IconButton(onPressed: _presentarDatePicker, icon: const Icon(Icons.calendar_month)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              DropdownButton<Categoria>(
                value: _categoriaSeleccionada,
                items: Categoria.values.map((cat) => DropdownMenuItem(value: cat, child: Text(cat.name.toUpperCase()))).toList(),
                onChanged: (value) { if (value != null) setState(() => _categoriaSeleccionada = value); },
              ),
              const Spacer(),
              TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
              ElevatedButton(onPressed: _enviarDatosGasto, child: const Text('Guardar Gasto')),
            ],
          ),
        ],
      ),
    );
  }
}