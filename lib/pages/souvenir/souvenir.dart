import 'dart:async';
import 'dart:convert';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:wedding_organizer/data/models/souvenir_model.dart';

class SouvenirPage extends StatefulWidget {
  const SouvenirPage({super.key});
  @override
  _SouvenirPageState createState() => _SouvenirPageState();
}

class _SouvenirPageState extends State<SouvenirPage> {
  num quantity = 1;
  Future<List<Souvenir>> getData() async {
      var jsonString = await rootBundle.loadString("assets/data.json");
      var data = json.decode(jsonString);
      return (data as List).map((e) => Souvenir.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Souvenir", style: TextStyle(color: Colors.white, fontSize: 30)),
        backgroundColor: Colors.pink[200],
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text("Error loading data."));
            } else {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  childAspectRatio: 0.6,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Card(
                        elevation: 4,
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              flex: 2,
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        snapshot.data![index].image),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Flexible(
                              flex: 1,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ListTile(
                                      titleAlignment:
                                          ListTileTitleAlignment.bottom,
                                      title: Text(
                                        snapshot.data![index].name,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      isThreeLine: false,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: 8,
                        bottom: 8,
                        child: 
                        Row(
                          children: [
                              InputQty(
                                    decoration: const QtyDecorationProps(
                                    isBordered: false,
                                    borderShape: BorderShapeBtn.none,
                                    width: 12,
                                    btnColor: Colors.pink
                                    ),
                                    qtyFormProps: QtyFormProps(enableTyping: false),
                                    maxVal: 99,
                                    initVal: 1,
                                    minVal: 1,
                                    steps: 1,
                                    
                                    onQtyChanged: (val) {
                                      quantity=val as num;
                                    },
                              ),
                              IconButton(
                              onPressed: () {
                                  FirebaseAnalytics.instance.logEvent(name: "Menambah_pesanan");
                              },
                              icon: const Icon(Icons.add_shopping_cart),
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.pink,
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ],
                        )
                        
                      ),
                    ],
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

