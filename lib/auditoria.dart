class Auditoria {
  int? id;
  String accion;

  Auditoria({this.id, required this.accion});

  // Convertir un objeto Auditoría en un Map para insertar en la base de datos
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'accion': accion,
    };
  }

  // Convertir un Map en un objeto Auditoría
  factory Auditoria.fromMap(Map<String, dynamic> map) {
    return Auditoria(
      id: map['id'],
      accion: map['accion'],
    );
  }
}
