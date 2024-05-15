import 'dart:io';
import 'dart:convert';
import '../models/models.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiService {
  final storage = new FlutterSecureStorage();

  final String _baseUrl = 'http://localhost:5033';
  final String _registerPath = 'api/authentication/register';
  final String _loginPath = 'api/authentication/login/email';
  final String _groupsPath = 'api/users/me/groups';
  final client = http.Client();

  Future<List<Group>> fetchGroups() async {
    final String? token = await storage.read(key: 'jwt'); 
    final response = await client.get(Uri.parse('$_baseUrl/$_groupsPath'),
      headers: {HttpHeaders.contentTypeHeader: "application/json", HttpHeaders.authorizationHeader: "Bearer $token"});

    if (response.statusCode == 200) {
      final List<dynamic> groupJson = json.decode(response.body);
      return groupJson.map((json) => Group.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load groups');
    }
  }

  // Добавьте другие методы для работы с API здесь
  Future<void> login(LoginModel model) async {
    var body = json.encode(model.toJson());
    final response = await client.post(
      Uri.parse('$_baseUrl/$_loginPath'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      }, 
      body: body);

    if (response.statusCode == 200) {
      final dynamic tokenJson = json.decode(response.body);
      final TokenModel token = TokenModel.fromJson(tokenJson);
      await storage.write(key: 'jwt', value: token.jwt);
      await storage.write(key: 'refreshToken', value: token.refreshToken);    
    } 
    else {
      throw Exception('Failed to register');
    }
  }

  Future<List<Item>> fetchGroupDetails(String groupId) async {
    final String? token = await storage.read(key: 'jwt');
    String groupItemsPath = 'api/groups/me/$groupId/needs';
    final response = await client.get(Uri.parse('$_baseUrl/$groupItemsPath'),
      headers: {HttpHeaders.contentTypeHeader: "application/json", HttpHeaders.authorizationHeader: "Bearer $token"});

    if (response.statusCode == 200) {
      final List<dynamic> groupItemsJson = json.decode(response.body);
      return groupItemsJson.map((json) => Item.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load group items');
    }
  }

  Future<List<String>> fetchProducts() async {
    final String? token = await storage.read(key: 'jwt');
    String groupItemsPath = 'api/products';
    final response = await client.get(Uri.parse('$_baseUrl/$groupItemsPath'),
      headers: {HttpHeaders.contentTypeHeader: "application/json", HttpHeaders.authorizationHeader: "Bearer $token"});

    if (response.statusCode == 200) {
      final List<dynamic> groupItemsJson = json.decode(response.body);
      return groupItemsJson.map((obj) => obj['name'] as String).toList();
    } else {
      throw Exception('Failed to load group items');
    }
  }
}