class Medico {
  int? id;
  String? nome;
  String? especialidade;

  Medico(this.nome, this.especialidade);

  Map toMap(){
    Map<String, Object?> map = {
      'nome': nome,
      'especialidade': especialidade
    };

    if (id != null) {
      map['id'] = id;
    }

    return map;
  }

  Medico.fromMap(Map map) {
    id = map['id'];
    nome = map['nome'];
    especialidade = map['especialidade'];
  }

}