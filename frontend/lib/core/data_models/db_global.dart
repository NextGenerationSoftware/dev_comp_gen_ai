class DBGlobal {
  DBGlobalGlobal? global;

  DBGlobal({
    this.global,
  });

  DBGlobal.fromJson(Map<String, dynamic> json) {
    global = DBGlobalGlobal.fromJson(json['global']);
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map["global"] = global?.toMap();
    return map;
  }
}

class DBGlobalGlobal {
  List<DBPointcats> pointcats = [];

  DBGlobalGlobal({
    this.pointcats = const [],
  });

  DBGlobalGlobal.fromJson(Map<String, dynamic> json) {
    pointcats = [];
    if (json['pointcats'] != null) {
      json['pointcats'].forEach((value) {
        pointcats.add(DBPointcats.fromJson(value));
      });
    }
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};

    List<Map<String, dynamic>> temp1 = [];
    for (DBPointcats element in pointcats) {
      temp1.add(element.toMap());
    }
    map["pointcats"] = temp1;

    return map;
  }
}

class DBPointcats {
  int? c;
  int? p;

  DBPointcats({
    this.c,
    this.p,
  });

  DBPointcats.fromJson(Map<String, dynamic> json) {
    c = json['c'];
    p = json['p'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map["c"] = c;
    map["p"] = p;
    return map;
  }

  DBPointcats deepCopy() {
    DBPointcats ret = DBPointcats();
    ret.c = c;
    ret.p = p;
    return ret;
  }
}
