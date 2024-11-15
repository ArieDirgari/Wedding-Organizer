import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wedding_organizer/data/models/decoration_models.dart';
import 'package:wedding_organizer/data/database/database_handler_vendor.dart';

class DecorationDetails extends StatefulWidget {
  final DecorationVendor decoration;
  const DecorationDetails({super.key, required this.decoration});

  @override
  State<DecorationDetails> createState() => _DecorationDetailsState();
}

class _DecorationDetailsState extends State<DecorationDetails> {
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  bool _isexpanded = false;
  int _current = 0;
  String? _selectedPackage;

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
                String nama = widget.decoration.nama;
                String deskripsi = widget.decoration.deskripsi;
                String hargaPaket =
                    _selectedPackage ?? widget.decoration.hargaPaket;
                List<String> sample = widget.decoration.sample;
                await DatabaseHelper.instance
                    .tambahDecoration(nama, deskripsi, hargaPaket, sample);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Vendor sudah tersimpan")),
                );
                analytics.logEvent(name: 'Vendor disimpan', parameters: {
        'vendor': widget.decoration.nama,
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
                widget.decoration.nama,
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
                    items: widget.decoration.sample.map((img) {
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
                      children:
                          widget.decoration.sample.asMap().entries.map((entry) {
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
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.decoration.nama,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text.rich(TextSpan(children: [
                      TextSpan(
                          text: _isexpanded
                              ? widget.decoration.deskripsi
                              : (widget.decoration.deskripsi.length > 40
                                  ? widget.decoration.deskripsi.substring(0, 50)
                                  : widget.decoration.deskripsi),
                          style: TextStyle(
                            fontSize: 16,
                            overflow: TextOverflow.ellipsis,
                          )),
                      TextSpan(
                        text: _isexpanded
                            ? " read less"
                            : (widget.decoration.deskripsi.length > 40
                                ? " ... read more"
                                : ""),
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            setState(() {
                              _isexpanded = !_isexpanded;
                            });
                          },
                      ),
                    ])),
                    
                    const SizedBox(height: 16),
                    Divider(
                      color: Colors.black,
                      height: 1,
                      thickness: 1,
                      
                    ),
                    SizedBox(height: 10,),
                    Text(
                      "Paket Harga:",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    RadioListTile<String>(
                      title: Text(widget.decoration.hargaPaket),
                      value: widget.decoration.hargaPaket,
                      groupValue: _selectedPackage,
                      controlAffinity: ListTileControlAffinity.trailing,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedPackage = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    
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
