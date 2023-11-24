@pragma('vm:entry-point')
class InspirationBaseResponse {
  String? command;
  String? path;
  bool? pro_user_access;
  bool? isFavorite = false;

  InspirationBaseResponse({
    required this.command,
    required this.path,
    required this.pro_user_access,
    this.isFavorite = false,
  });

  factory InspirationBaseResponse.fromJson(Map<String, dynamic> json) {
    return InspirationBaseResponse(
      command: json['command'] as String? ?? '',
      path: json['path'] as String? ?? '',
      pro_user_access: json['pro_user_access'] as bool? ?? false,
      isFavorite: false,
    );
  }
}

/*class Root {
  String? command;
  String? path;
  bool? prouseraccess;
  Root({this.command, this.path, this.prouseraccess,this.isFavorite});

  Root.fromJson(Map<String, dynamic> json) {
    command = json['command'];
    path = json['path'];
    prouseraccess = json['pro_user_access'];
    isFavorite = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['command'] = command;
    data['path'] = path;
    data['pro_user_access'] = prouseraccess;
    return data;
  }
}*/
