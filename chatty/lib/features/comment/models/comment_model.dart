class CommentModel{
  String? userId;
  String? text;
  String? userImage;
  String? userName;

  CommentModel.fromJson(Map<String, dynamic> data){
    userId = data['userId'];
    text = data['text'];
  }

  CommentModel({this.userId, this.text});

  Map<String, dynamic> toJson(){
    return{
      'userId': userId,
      'text': text
    };
  }
}