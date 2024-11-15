import 'package:flutter/material.dart';

class Vendor extends StatefulWidget {
  const Vendor({super.key});

  @override
  State<Vendor> createState() => _VendorState();
}

class _VendorState extends State<Vendor> {
  final List<Map<String, String>> vendors = [
    {
      "title": "Photographer",
      "description": "Fotografi pernikahan.",
      "imageUrl":
          "https://www.brides.com/thmb/n2D-fmnb8I8Tpgm08jzs1YxfDzc=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/questions-to-asj-wedding-photographer-recirc-getty-images--61ea34e9e287426d9ca41ae4615e964a.jpg",
      "route": "/photographersList"
    },
    // {
    //   "title": "Caterer",
    //   "description": "Layanan katering, kue pernikahan.",
    //   "imageUrl":
    //       "https://weddingmarket.com/storage/images/artikelidea/a954161cad048eb8b77d5ffe0cd67db4ff2d5687.webp",
    //   "route": "/caterersList"
    // },
    {
      "title": "Decoration",
      "description": "Dekorasi pernikahan.",
      "imageUrl":
          "https://siopen.balangankab.go.id/storage/merchant/products/2024/01/31/2e6a197664d769c7cfe0776a5db8f0b0.jpg",
      "route": "/decorationsList"
    },
    {
      "title": "Wedding Band",
      "description": "Musik dan hiburan.",
      "imageUrl":
          "https://london.bridestory.com/image/upload/c_fill,dpr_1.0,f_auto,fl_progressive,h_340,pg_1,q_80,w_574/v1/assets/joj07234-kecil-2-HydojB1dP.jpg",
      "route": "/weddingBandsList"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text(
              "Vendor",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
            backgroundColor: Colors.pink[200],
            pinned: false,
            floating: true,
            snap: true,
  
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final vendor = vendors[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, vendor["route"]!);
                    },
                    
                    child: 
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: Card(
                      color: Colors.white,
                      elevation: 3,
                      child: 
                      Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(vendor["imageUrl"]!),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                vendor["title"]!,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                vendor["description"]!,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                    ),)
                    
                    
                  );
                },
                childCount: vendors.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
