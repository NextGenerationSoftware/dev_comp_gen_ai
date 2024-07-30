class DBDatarequired {
  String? id;
  String? customerid;
  String? description;
  int? pointcat;

  DBDatarequired({
    this.id,
    this.customerid,
    this.description,
    this.pointcat,
  });

  DBDatarequired.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerid = json['customerid'];
    description = json['description'];
    pointcat = json['pointcat'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map["id"] = id;
    map["customerid"] = customerid;
    map["description"] = description;
    map["pointcat"] = pointcat;
    return map;
  }
}
