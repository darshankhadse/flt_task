import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UrlTileProvider implements TileProvider {
  final String urlTemplate;
  Uint8List tileBytes = Uint8List(0);
  UrlTileProvider(this.urlTemplate);

  @override
  Future<Tile> getTile(int x, int y, int? zoom) async {
    final url = urlTemplate
        .replaceAll('{x}', x.toString())
        .replaceAll('{y}', y.toString())
        .replaceAll('{z}', zoom.toString());
    if (TilesCache.tiles.containsKey(url)) {
      tileBytes = TilesCache.tiles[url]!;
    } else {
      final uri = Uri.parse(url);
      final ByteData imageData = await NetworkAssetBundle(uri).load("");
      tileBytes = imageData.buffer.asUint8List();
      TilesCache.tiles[url] = tileBytes;
    }
    return Tile(256,256,tileBytes);
  }
}

class TilesCache {
  static Map<String, Uint8List> tiles = {};
}