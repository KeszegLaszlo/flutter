import 'dart:convert';
import 'package:http/http.dart' as http;
import 'model/Album.dart';

abstract class AlbumRepository {
  Future<List<Album>> fetchAlbums();
  Future<List<Album>> fetchMockAlbums();
  Future<List<Album>> fetchError();
}

class AlbumRepositoryImpl implements AlbumRepository {
  static const String _apiUrl = 'https://jsonplaceholder.typicode.com/albums';

  @override
  Future<List<Album>> fetchAlbums() async {
    final response = await http.get(Uri.parse(_apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Album.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load albums');
    }
  }

  @override
  Future<List<Album>> fetchMockAlbums() async {
    return [
      Album(userId: 1, id: 1, title: 'Mock Album 1'),
      Album(userId: 2, id: 2, title: 'Mock Album 2'),
    ];
  }

  @override
  Future<List<Album>> fetchError() async {
    throw Exception('Mock error');
  }
}
