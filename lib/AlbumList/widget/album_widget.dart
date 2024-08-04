import 'package:flutter/material.dart';
import 'package:mentoring/AlbumList/widget/album_search.dart';
import 'package:provider/provider.dart';
import '../viewmodel/album_viewmodel.dart';
import '../repository/album_repository.dart';
import '../repository/model/Album.dart';

class AlbumScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AlbumViewModel>(
      create: (context) => AlbumViewModel(AlbumRepositoryImpl())..fetchAlbums(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Albumok'),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: AlbumSearchDelegate(context.read<AlbumViewModel>()),
                );
              },
            ),
          ],
        ),
        body: AlbumList(),
      ),
    );
  }
}

class AlbumList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AlbumViewModel>(
      builder: (context, albumViewModel, child) {
        return StreamBuilder<List<Album>>(
          stream: albumViewModel.albumsStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Hiba: ${snapshot.error}'));
            }
            final albums = snapshot.data ?? [];
            if (albums.isEmpty) {
              return const Center(child: Text('Nincsenek elérhető albumok'));
            }
            return ListView.builder(
              itemCount: albums.length,
              itemBuilder: (context, index) {
                final album = albums[index];
                return AlbumListTile(album: album);
              },
            );
          },
        );
      },
    );
  }
}

class AlbumListTile extends StatelessWidget {
  final Album album;

  const AlbumListTile({required this.album});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(album.title),
    );
  }
}
