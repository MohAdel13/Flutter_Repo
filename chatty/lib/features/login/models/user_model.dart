class UserModel{
  String? name;
  String? email;
  String? uId;
  String? phone;
  String? image;
  String? coverImage;

  UserModel({
    required this.name,
    required this.email,
    required this.uId,
    required this.phone,
    this.image,
    this.coverImage
  });

  UserModel.fromJson(Map<String, dynamic> json){
    name = json['name'];
    email = json['email'];
    uId = json['uId'];
    phone = json['phone'];
    image = json['image'];
    coverImage = json['coverImage'];
  }

  Map<String, dynamic> toJson(){
    return {
      'name': name,
      'email': email,
      'uId': uId,
      'phone': phone,
      'image': image,
      'coverImage': coverImage
    };
  }
}