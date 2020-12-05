class Nit {
  int id;
  String cEmp;
  String nIde;
  String nom;
  String ide;
  String dir;
  String tel;
  String fax;
  String tlx;
  String aa;
  String est;
  String nom1;
  String nom2;
  String ape1;
  String ape2;
  String dirElect;
  String dig;
  String tipoNit;
  String tipContrib;
  String tipTerc;
  DateTime fecha;

  Nit(
      {this.id,
      this.cEmp,
      this.nIde,
      this.nom,
      this.ide,
      this.dir,
      this.tel,
      this.fax,
      this.tlx,
      this.aa,
      this.est,
      this.nom1,
      this.nom2,
      this.ape1,
      this.ape2,
      this.dirElect,
      this.dig,
      this.tipoNit,
      this.tipContrib,
      this.tipTerc,
      this.fecha});

  factory Nit.fromJson(Map<String, dynamic> json) => Nit(
        id: json["Id"],
        cEmp: json["C_EMP"],
        nIde: json["N_IDE"],
        nom: json["NOM"],
        ide: json["IDE"],
        dir: json["DIR"],
        tel: json["TEL"],
        fax: json["FAX"],
        tlx: json["TLX"],
        aa: json["AA"],
        est: json["EST"],
        nom1: json["NOM1"],
        nom2: json["NOM2"],
        ape1: json["APE1"],
        ape2: json["APE2"],
        dirElect: json["DIR_ELECT"],
        dig: json["DIG"],
        tipoNit: json["TIPO_NIT"],
        tipContrib: json["TIP_CONTRIB"],
        tipTerc: json["TIP_TERC"],
        fecha: DateTime.parse(json["FECHA"]),
      );

  Map<String, dynamic> toJson() => {
        "C_EMP": cEmp,
        "N_IDE": nIde,
        "NOM": nom ?? " ",
        "IDE": ide,
        "DIR": dir,
        "TEL": tel,
        "FAX": fax,
        "TLX": tlx,
        "AA": aa,
        "EST": est,
        "NOM1": nom1,
        "NOM2": nom2,
        "APE1": ape1,
        "APE2": ape2,
        "DIR_ELECT": dirElect,
        "DIG": dig,
        "TIPO_NIT": tipoNit,
        "TIP_CONTRIB": tipContrib,
        "TIP_TERC": tipTerc,
        "FECHA":
            "${fecha.year.toString().padLeft(4, '0')}-${fecha.month.toString().padLeft(2, '0')}-${fecha.day.toString().padLeft(2, '0')}",
      };
}
