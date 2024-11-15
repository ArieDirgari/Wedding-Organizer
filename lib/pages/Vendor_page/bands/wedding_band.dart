import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wedding_organizer/pages/Vendor_page/bands/wedding_bands_details.dart';
import 'dart:convert';
import 'package:wedding_organizer/data/models/wedding_bands.dart';


class WeddingBandList extends StatefulWidget {
  const WeddingBandList({super.key});

  @override
  State<WeddingBandList> createState() => _WeddingBandListState();
}

class _WeddingBandListState extends State<WeddingBandList> {
  Future<List<WeddingBand>> fetchWeddingBands() async {
    final url = "https://gist.githubusercontent.com/ArieDirgari/457466ab4f596e19ff467d6d2d952edf/raw/c750d5faaebe81de6fbef3bca82ab051773b989c/wedding_band.json";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return (data as List).map((e) => WeddingBand.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load wedding bands");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<List<WeddingBand>>(
        future: fetchWeddingBands(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error loading data."));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No data available."));
          } else {
            final bands = snapshot.data!;
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: const Text(
                    "Wedding Bands",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: Colors.pink[200],
                  foregroundColor: Colors.white,
                  centerTitle: true,
                  pinned: false,
                  floating: true,
                  snap: true,
                  expandedHeight: 60,
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final band = bands[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    WeddingBandDetails(band: band),
                              ),
                            );
                          },
                          child: Card(
                            color: Colors.white,
                            margin: const EdgeInsets.only(bottom: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 200,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(band.sample.first),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      topRight: Radius.circular(8),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            band.nama,
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            band.hargaPaket,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.pinkAccent,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        band.deskripsi.length > 100
                                            ? "${band.deskripsi.substring(0, 100)}..."
                                            : band.deskripsi,
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      childCount: bands.length,
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
