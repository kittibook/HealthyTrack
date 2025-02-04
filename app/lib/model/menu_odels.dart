

// Model Classes

class MenuModel {
  String successfull;
  List<Datum> data;

  MenuModel({
    required this.successfull,
    required this.data,
  });

  factory MenuModel.fromJson(Map<String, dynamic> json) {
    return MenuModel(
      successfull: json['successfull'],
      data: List<Datum>.from(json['data'].map((x) => Datum.fromJson(x))),
    );
  }
}

class Datum {
  int id;
  String name;
  List<Menudatum> menudata;

  Datum({
    required this.id,
    required this.name,
    required this.menudata,
  });

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      id: json['id'],
      name: json['name'],
      menudata: List<Menudatum>.from(json['menudata'].map((x) => Menudatum.fromJson(x))),
    );
  }
}

class Menudatum {
  int id;
  int menuid;
  String name;
  int kcal;

  Menudatum({
    required this.id,
    required this.menuid,
    required this.name,
    required this.kcal,
  });

  factory Menudatum.fromJson(Map<String, dynamic> json) {
    return Menudatum(
      id: json['id'],
      menuid: json['menuid'],
      name: json['name'],
      kcal: json['Kcal'],
    );
  }
}