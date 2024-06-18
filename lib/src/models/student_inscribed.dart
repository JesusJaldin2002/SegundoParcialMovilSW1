class StudentInscribed {
  final int id;
  final String name;
  String observacion;
  String estado;

  StudentInscribed({
    required this.id,
    required this.name,
    this.observacion = '',
    this.estado = 'absent', // Valor predeterminado para estado
  });

  factory StudentInscribed.fromJson(Map<String, dynamic> json) {
    return StudentInscribed(
      id: json['id'],
      name: json['name'],
      observacion: json['observacion'] ?? '',
      estado: json['estado'] ?? 'absent',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'observacion': observacion,
      'estado': estado,
    };
  }
}
