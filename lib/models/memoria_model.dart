import 'package:cloud_firestore/cloud_firestore.dart';

class Memoria {
  final String? titulo;
  final String? corpo;
  final DateTime? data;

  Memoria({required this.titulo, required this.corpo, required this.data});

  static Memoria fromJson(Map<String, dynamic> json) =>
      Memoria(titulo: json['titulo'], corpo: json['corpo'], data: (json['data'] as Timestamp).toDate());
}
