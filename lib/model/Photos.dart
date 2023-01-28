class Photos {
  Photos({
      this.albumId, 
      this.id, 
      this.title, 
      this.url, 
      this.thumbnailUrl,});

  Photos.fromJson(dynamic json) {
    albumId = json['albumId'];
    id = json['id'];
    title = json['title'];
    url = json['url'];
    thumbnailUrl = json['thumbnailUrl'];
  }
  int? albumId;
  int? id;
  String? title;
  String? url;
  String? thumbnailUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['albumId'] = albumId;
    map['id'] = id;
    map['title'] = title;
    map['url'] = url;
    map['thumbnailUrl'] = thumbnailUrl;
    return map;
  }

  @override
  String toString() {
    return 'Photos{albumId: $albumId, id: $id, title: $title, url: $url, thumbnailUrl: $thumbnailUrl}';
  }
}