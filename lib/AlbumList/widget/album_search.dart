import 'package:flutter/material.dart';
import '../viewmodel/album_viewmodel.dart';
import '../repository/model/Album.dart';

class AlbumSearchDelegate extends SearchDelegate<Album?> {
  final AlbumViewModel albumViewModel;

  AlbumSearchDelegate(this.albumViewModel);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      // Clear button
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          albumViewModel.searchAlbums(query);
        },
      ),
      // Search button
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: () {
          albumViewModel.searchAlbums(query);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildAlbumList();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildAlbumList();
  }

  Widget _buildAlbumList() {
    albumViewModel.searchAlbums(query);

    return StreamBuilder<List<Album>>(
      stream: albumViewModel.albumsStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final albums = snapshot.data ?? [];
        final filteredAlbums = _filterAlbums(albums);

        if (filteredAlbums.isEmpty) {
          return const Center(child: Text('No results found'));
        }

        return ListView.builder(
          itemCount: filteredAlbums.length,
          itemBuilder: (context, index) {
            final album = filteredAlbums[index];
            return ListTile(
              title: Text(album.title),
              onTap: () {
                close(context, album);
              },
            );
          },
        );
      },
    );
  }

  List<Album> _filterAlbums(List<Album> albums) {
    final queryLowerCase = query.toLowerCase();
    return albums.where((album) {
      return album.title.toLowerCase().contains(queryLowerCase);
    }).toList();
  }
}
