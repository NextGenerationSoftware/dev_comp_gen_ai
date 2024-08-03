class DBDatataken {
  String? id;
  String? userid;
  String? url;
  String? path;
  String? label;
  int? pointcat;
  int? points;
  String? datarequiredid;
  DateTime? timestamp;

  DBDatataken({
    this.id,
    this.userid,
    this.url,
    this.path,
    this.label,
    this.pointcat,
    this.points,
    this.datarequiredid,
    this.timestamp,
  });

  DBDatataken.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userid = json['userid'];
    url = json['url'];
    path = json['path'];
    label = json['label'];
    pointcat = json['pointcat'];
    points = json['points'];
    datarequiredid = json['datarequiredid'];
    timestamp = json['timestamp']?.toDate();
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
    map["datarequiredid"] = datarequiredid;
    map["timestamp"] = timestamp;
    return map;
  }
}
