class DBUser {
  String? id;
  String? name;
  int? pointsspent;

  DBUser({
    this.id,
    this.name,
    this.pointsspent,
  });

  DBUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    pointsspent = json['pointsspent'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map["id"] = id;
    map["name"] = name;
    map["pointsspent"] = pointsspent;
    return map;
  }
}
