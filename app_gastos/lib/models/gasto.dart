import 'package:flutter/material.dart';

enum Categoria { comida, viaje, trabajo, ocio }

// Mapeo de iconos según las imágenes proporcionadas
const iconosCategoria = {
  Categoria.comida: Icons.restaurant,
  Categoria.viaje: Icons.flight,
  Categoria.trabajo: Icons.work,
  Categoria.ocio: Icons.movie,
};

class Gasto {
  Gasto({
    required this.titulo,
    required this.cantidad,
    required this.fecha,
    required this.categoria,
  });

  final String titulo;
  final double cantidad;
  final DateTime fecha;
  final Categoria categoria;
}