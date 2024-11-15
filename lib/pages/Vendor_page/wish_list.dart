import 'package:flutter/material.dart';
import 'package:wedding_organizer/data/models/photographer_models.dart';
import 'package:wedding_organizer/data/models/wedding_bands.dart';
import 'package:wedding_organizer/data/database/database_handler_vendor.dart';
import 'package:wedding_organizer/data/models/decoration_models.dart';

class WishList extends StatefulWidget {
  @override
  _WishListState createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  List<DecorationVendor> decorations = [];
  List<Photographer> photographers = [];
  List<WeddingBand> musicBands = [];

  @override
  void initState() {
    super.initState();
    fetchVendors();
  }

  Future<void> fetchVendors() async {
    final dbHelper = DatabaseHelper.instance;

    final decos = await dbHelper.getDecorations();
    final photos = await dbHelper.getPhotographers();
    final bands = await dbHelper.getMusicBands();

    setState(() {
      decorations = decos;
      photographers = photos;
      musicBands = bands;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vendor List'),
      ),
      body: ListView(
        children: [
          if (decorations.isNotEmpty) ...[
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Decorations', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            ...decorations.map((deco) => ListTile(
                  title: Text(deco.nama),
                  subtitle: Text('${deco.deskripsi}\nHarga: ${deco.hargaPaket}'),
                  isThreeLine: true,
                )),
          ],
          if (photographers.isNotEmpty) ...[
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Photographers', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            ...photographers.map((photo) => ListTile(
                  title: Text(photo.nama),
                  subtitle: Text('${photo.deskripsi}\nHarga: ${photo.hargaPaket}'),
                  isThreeLine: true,
                )),
          ],
          if (musicBands.isNotEmpty) ...[
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Music Bands', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            ...musicBands.map((band) => ListTile(
                  title: Text(band.nama),
                  subtitle: Text('${band.deskripsi}\nHarga: ${band.hargaPaket}'),
                  isThreeLine: true,
                )),
          ],
        ],
      ),
    );
  }
}
