class Data {
  int? id;

  Data({this.id});

  factory Data.fromJson(Map<String, dynamic> json) =>
      Data(id: json['id'] as int?);

  Map<String, dynamic> toJson() => {'id': id};
}
