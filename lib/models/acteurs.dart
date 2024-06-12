class Acteur {
  String personneId;
  String nom;
  String? metaphone;
  String? naissance;
  int? age;
  Null? deces;
  String? nationalite;
  String? drapeauUnicode;
  int nbFilm;
  double? popularite;

  Acteur(
      {required this.personneId,
      required this.nom,
      this.metaphone,
      this.naissance,
      this.age,
      this.deces,
      this.nationalite,
      this.drapeauUnicode,
      required this.nbFilm,
      this.popularite});

  Acteur.fromJson(Map<String, dynamic> json)
      : personneId = json['personne_id'] ?? "0000",
        nom = json['nom'] ?? "inconnu",
        metaphone = json['metaphone'],
        naissance = json['naissance'],
        age = json['age'],
        deces = json['deces'],
        nationalite = json['nationalite'],
        drapeauUnicode = json['drapeau_unicode'],
        nbFilm = json['nb_film'],
        popularite = json['popularite'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['personne_id'] = this.personneId;
    data['nom'] = this.nom;
    data['metaphone'] = this.metaphone;
    data['naissance'] = this.naissance;
    data['age'] = this.age;
    data['deces'] = this.deces;
    data['nationalite'] = this.nationalite;
    data['drapeau_unicode'] = this.drapeauUnicode;
    data['nb_film'] = this.nbFilm;
    data['popularite'] = this.popularite;
    return data;
  }
}
