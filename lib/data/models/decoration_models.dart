class DecorationVendor {
  final int dcId;
  final String nama;
  final String deskripsi;
  final String hargaPaket;
  final List<String> sample;

  DecorationVendor({
    required this.dcId,
    required this.nama,
    required this.deskripsi,
    required this.hargaPaket,
    required this.sample,
  });

  factory DecorationVendor.fromJson(Map<String, dynamic> json) {
    return DecorationVendor(
      dcId: json['dc_id'] ,
      nama: json['nama'] as String,
      deskripsi: json['deskripsi'] as String,
      hargaPaket: json['harga_paket'] as String,
      sample: List<String>.from(json['sample'] as List<dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dc_id': dcId,
      'nama': nama,
      'deskripsi': deskripsi,
      'harga_paket': hargaPaket,
      'sample': sample,
    };
  }
}
