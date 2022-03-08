import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Username{
  static var username;
}

Future<Album> fetchAlbum() async {
  final response =
  await http.get(Uri.parse('https://api.github.com/users/${Username.username}'));

  print(Username.username);

  // Appropriate action depending upon the
  // server response
  if(response.statusCode == 404){
    throw Exception('Account not found! Check the username again');
  }

  else if (response.statusCode == 200) {
    return Album.fromJson(json.decode(response.body));
  }
  else {
    throw Exception('Failed to load data');
  }
}


class Album {
  final String nodeId;
  final int id;
  final int followers;
  final int following;
  final String login;

  Album({this.nodeId, this.id, this.login, this.followers, this.following});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      nodeId: json['node_id'],
      id: json['id'],
      login: json['login'],
      followers: json['followers'],
      following: json['following'],
    );
  }
}