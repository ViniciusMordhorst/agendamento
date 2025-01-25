class Agendamento {
  int? id;
  String? nome;
  String? data;
  String? doutor;

  Agendamento(this.nome, this.data, this.doutor);

  Map toMap(){
    Map<String, Object?> map = {
      'nome': nome,
      'data': data,
      'doutor': doutor,
    };

    if (id != null) {
      map['id'] = id;
    }

    return map;
  }

  Agendamento.fromMap(Map map) {
    id = map['id'];
    data = map['data'];
    doutor = map['doutor'];
  }

}