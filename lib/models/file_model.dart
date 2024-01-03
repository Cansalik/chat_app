class FileModel {
  Id id;
  String title;
  Id userId;
  String type;
  String url;
  String imageUrl;
  AtedAt createdAt;
  AtedAt updatedAt;
  V v;

  FileModel({
    required this.id,
    required this.title,
    required this.userId,
    required this.type,
    required this.url,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

}

class AtedAt {
  Date date;

  AtedAt({
    required this.date,
  });

}

class Date {
  String numberLong;

  Date({
    required this.numberLong,
  });

}

class Id {
  String oid;

  Id({
    required this.oid,
  });

}

class V {
  String numberInt;

  V({
    required this.numberInt,
  });

}
