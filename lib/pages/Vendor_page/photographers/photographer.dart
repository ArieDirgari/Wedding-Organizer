import 'package:flutter/material.dart';
import 'package:wedding_organizer/data/models/photographer_models.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:wedding_organizer/pages/Vendor_page/photographers/photographer_details.dart';

class PhotographerList extends StatefulWidget {
  const PhotographerList({super.key});

  @override
  State<PhotographerList> createState() => _PhotographerListState();
}

class _PhotographerListState extends State<PhotographerList> {
  Future<List<Photographer>> fetchPhotographers() async {
    final url =
        "https://gist.githubusercontent.com/ArieDirgari/457466ab4f596e19ff467d6d2d952edf/raw/c750d5faaebe81de6fbef3bca82ab051773b989c/photographer_detail.json";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return (data as List).map((e) => Photographer.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load photographers");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<List<Photographer>>(
        future: fetchPhotographers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error loading data."));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No data available."));
          } else {
            final photographers = snapshot.data!;
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: Text(
                    "Photographers",
                    style: const TextStyle(
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
                        final photographer = photographers[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PhotographerDetails(
                                    photographer: photographer),
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
                                      image: NetworkImage(
                                          photographer.sample.first),
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
                                            photographer.nama,
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "${photographer.rating}⭐",
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        photographer.deskripsi,
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
                      childCount: photographers.length,
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
