class GetOnePostResponse {
  int? id;
  String? title;
  String? body;
  String? photo;

  GetOnePostResponse({this.id, this.title, this.body, this.photo});

  GetOnePostResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    data['photo'] = this.photo;
    return data;
  }
}