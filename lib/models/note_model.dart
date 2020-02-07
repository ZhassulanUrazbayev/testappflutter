class Note{
  int id;
  String title;
  String data;

  Note({
    this.id,
    this.title,
    this.data,
  });

  factory Note.fromMap(Map<String, dynamic> json) => new Note(
    id: json["id"],
    title: json["title"],
    data: json["data"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "data": data,
  };

}