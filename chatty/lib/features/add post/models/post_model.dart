class PostModel{
  String? uId;
  String? dateTime;
  String? text;
  String? postImage;
  String? name;
  String? image;
  String? postId;
  bool? liked;

  PostModel({
    required this.uId,
    required this.dateTime,
    required this.text,
    required this.postImage
  });

  PostModel.fromJson(Map<String, dynamic> json){
    uId = json['uId'];
    dateTime = json['dateTime'];
    text = json['text'];
    postImage = json['postImage'];
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> data = {
      'uId': uId,
      "dateTime": dateTime,
      'text': text,
      'postImage': postImage,
    };
    return data;
  }
}