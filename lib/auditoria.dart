class Auditoria {
  int? id;
  String accion;

  Auditoria({this.id, required this.accion});


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'accion': accion,
    };
  }


  factory Auditoria.fromMap(Map<String, dynamic> map) {
    return Auditoria(
      id: map['id'],
      accion: map['accion'],
    );
  }
}
