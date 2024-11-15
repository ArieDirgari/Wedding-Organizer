import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:wedding_organizer/data/models/photographer_models.dart';
import 'package:wedding_organizer/data/database/database_handler_vendor.dart';

class PhotographerDetails extends StatefulWidget {
  final Photographer photographer;
  
  const PhotographerDetails({super.key, required this.photographer});
  

  @override
  State<PhotographerDetails> createState() => _PhotographerDetailsState();
}

class _PhotographerDetailsState extends State<PhotographerDetails> {
  int _current = 0;
  String? _selectedPackage;
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () async {
                String nama = widget.photographer.nama;
                String deskripsi = widget.photographer.deskripsi;
                String hargaPaket = _selectedPackage ?? widget.photographer.hargaPaket[0].harga;
                List<String> sample = widget.photographer.sample;
                await DatabaseHelper.instance.tambahPhotographer(nama, deskripsi, hargaPaket, sample);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Vendor sudah disimpan")),
                );
                analytics.logEvent(name: 'Vendor disimpan', parameters: {
        'vendor': widget.photographer.nama,
      });
              },
              child: const Text(
                "Simpan ke wish list",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: Text(
                widget.photographer.nama,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Colors.pink[200],
              foregroundColor: Colors.white,
              pinned: false,
              floating: true,
              snap: true,
              expandedHeight: 60,
              centerTitle: true,
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  CarouselSlider(
                    items: widget.photographer.sample.map((img) {
                      return Container(
                        width: double.infinity,
                        child: Image.network(
                          img,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const Center(
                                child: CircularProgressIndicator());
                          },
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(
                            Icons.error,
                            color: Colors.red,
                          ),
                        ),
                      );
                    }).toList(),
                    options: CarouselOptions(
                      viewportFraction: 1.0,
                      height: 300,
                      enableInfiniteScroll: false,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                        });
                      },
                    ),
                  ),
                  Positioned(
                    top: 250,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: widget.photographer.sample
                          .asMap()
                          .entries
                          .map((entry) {
                        return GestureDetector(
                          onTap: () => setState(() {
                            _current = entry.key;
                          }),
                          child: Container(
                            width: 12.0,
                            height: 12.0,
                            margin: const EdgeInsets.fromLTRB(4, 20, 4, 5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _current == entry.key
                                  ? Colors.pinkAccent
                                  : Colors.white,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.photographer.nama,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.photographer.deskripsi,
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "HP: ${widget.photographer.telepon}",
                      style: const TextStyle(fontSize: 14),
                    ),
                    Text(
                      "Email: ${widget.photographer.email}",
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    Text("Media Sosial: "),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.facebook),
                          onPressed: () {
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.camera_alt_outlined),
                          onPressed: () {
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Divider(
                      color: Colors.black,
                      height: 1,
                      thickness: 1,
                      
                    ),
                    SizedBox(height: 10,),
                    const Text(
                      "Paket Harga:",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Column(
                      children: widget.photographer.hargaPaket.map((paket) {
                        return RadioListTile<String>(
                          title: Text(paket.namaPaket),
                          subtitle: Text(paket.harga),
                          value: paket.harga,
                          groupValue: _selectedPackage,
                          controlAffinity: ListTileControlAffinity.trailing,
                          onChanged: (String? value) {
                            setState(() {
                              _selectedPackage = value;
                            });
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16,)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
