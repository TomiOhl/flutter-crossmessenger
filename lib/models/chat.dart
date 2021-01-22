class Chat {
  final int id;
  final String title;

  const Chat({
    this.id,
    this.title
  });

  set id(int newId) => id = newId;
  set title(String newTitle) => title = newTitle;

  Map<String, dynamic> toMap() {
    Map map = <String, dynamic>{
      'id': id,
      'title': title,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }
}