class DBUser {
  String? id;
  String? name;

  DBUser({
    this.id,
    this.name,
  });

  DBUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map["id"] = id;
    map["name"] = name;
    return map;
  }
}
