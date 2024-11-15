import 'package:flutter/material.dart';
import 'package:wedding_organizer/pages/Vendor_page/decorations/decoration_details.dart';
import 'package:wedding_organizer/data/models/decoration_models.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:wedding_organizer/pages/Vendor_page/wish_list.dart';

class DecorationList extends StatefulWidget {
  const DecorationList({super.key});

  @override
  State<DecorationList> createState() => _DecorationListState();
}

class _DecorationListState extends State<DecorationList> {
  Future<List<DecorationVendor>> fetchDecorations() async {
    final url =
        "https://gist.githubusercontent.com/ArieDirgari/457466ab4f596e19ff467d6d2d952edf/raw/c750d5faaebe81de6fbef3bca82ab051773b989c/decoration_detail.json";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return (data as List).map((e) => DecorationVendor.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load decorations");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<List<DecorationVendor>>(
        future: fetchDecorations(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error loading data."));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No data available."));
          } else {
            final decorations = snapshot.data!;
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: Text(
                    "Decorations",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // actions: [
                  //   IconButton(onPressed: (){
                  //     Navigator.push(
                  //             context,
                  //             MaterialPageRoute(
                  //               builder: (context) => WishList(),
                  //             ),
                  //           );
                  //   },
                  //   icon: Icon(Icons.favorite, color: Colors.white,size: 30))
                  // ],
                  backgroundColor:  Colors.pink[200],
                  foregroundColor: Colors.white,
                  pinned: false,
                  floating: true,
                  snap: true,
                  expandedHeight: 60,
                  centerTitle: true,
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final decoration = decorations[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DecorationDetails(decoration: decoration),
                              ),
                            );
                          },
                          child: Card(
                            color: Colors.white,
                            elevation: 5,
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
                                      image:
                                          NetworkImage(decoration.sample.first),
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
                                            decoration.nama,
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            decoration.hargaPaket,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.pinkAccent,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        decoration.deskripsi.length > 100 ? "${decoration.deskripsi.substring(0, 100)}..."
                                            : decoration.deskripsi,
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      const SizedBox(height: 8),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      childCount: decorations.length,
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
