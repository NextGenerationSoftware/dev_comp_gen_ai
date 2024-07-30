class DBDatataken {
  String? id;
  String? userid;
  String? url;
  String? path;
  String? label;
  int? pointcat;
  int? points;

  DBDatataken({
    this.id,
    this.userid,
    this.url,
    this.path,
    this.label,
    this.pointcat,
    this.points,
  });

  DBDatataken.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userid = json['userid'];
    url = json['url'];
    path = json['path'];
    label = json['label'];
    pointcat = json['pointcat'];
    points = json['points'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map["id"] = id;
    map["userid"] = userid;
    map["url"] = url;
    map["path"] = path;
    map["label"] = label;
    map["pointcat"] = pointcat;
    map["points"] = points;
    return map;
  }
}
