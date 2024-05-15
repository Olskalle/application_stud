// models.dart


class Item {
  String id;
  String name;
  bool isAccomplished;

  Item({
    this.id = '',
    required this.name,
    this.isAccomplished = false,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'].toString(), // Assuming the Id property is a string
      name: json['name'] ?? '', // Assuming the Name property is a string
      isAccomplished: json['isAccomplished'] ?? false, // Assuming the IsAccomplished property is a boolean
    );
  }
}

class Group {
  String id; 
  String name;
  List<Item> items;

  Group({required this.id, required this.name, required this.items});

  factory Group.fromJson(Map<String, dynamic> json) {
    List<dynamic> needsJson = json['needs'] ?? [];
    List<Item> items = needsJson.map((need) => Item.fromJson(need)).toList();

    return Group(
      id: json['id'],
      name: json['name'],
      items: items,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'items': items,
  };
}

class LoginModel {
  String email;
  String password;

  LoginModel({required this.email, required this.password});

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
  };
}

class TokenModel {
  String jwt;
  String refreshToken;

  TokenModel({required this.jwt, required this.refreshToken});

  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
      jwt: json['token'],
      refreshToken: json['refreshToken'],
    );
  }
}
