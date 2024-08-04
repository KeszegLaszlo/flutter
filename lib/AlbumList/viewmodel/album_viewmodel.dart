import 'dart:async';
import 'package:flutter/material.dart';
import '../repository/album_repository.dart';
import '../repository/model/Album.dart';

class AlbumViewModel extends ChangeNotifier {
  final AlbumRepository _albumRepository;
  final StreamController<List<Album>> _albumsController = StreamController<List<Album>>.broadcast();
  final StreamController<String> _errorController = StreamController<String>.broadcast();
  List<Album> _albums = [];

  AlbumViewModel(this._albumRepository) {
    fetchAlbums();
  }

  Stream<List<Album>> get albumsStream => _albumsController.stream;
  Stream<String> get errorStream => _errorController.stream;

  Future<void> fetchAlbums() async {
    _albumsController.add([]);
    _errorController.add('');

    try {
      _albums = await _albumRepository.fetchAlbums();
      _albumsController.add(_albums);
    } catch (e) {
      _albumsController.add([]);
      _errorController.add(e.toString());
    }
  }

  void searchAlbums(String query) {
    final filteredAlbums = _albums.where((album) => album.title.toLowerCase().contains(query.toLowerCase())).toList();
    _albumsController.add(filteredAlbums);
  }

  @override
  void dispose() {
    _albumsController.close();
    _errorController.close();
    super.dispose();
  }
}
