class WeddingBand {
  final int mbId;
  final String nama;
  final String deskripsi;
  final String hargaPaket;
  final List<String> sample;

  WeddingBand({
    required this.mbId,
    required this.nama,
    required this.deskripsi,
    required this.hargaPaket,
    required this.sample,
  });

  factory WeddingBand.fromJson(Map<String, dynamic> json) {
    return WeddingBand(
      mbId: json['mb_id'],
      nama: json['nama'],
      deskripsi: json['deskripsi'],
      hargaPaket: json['harga_paket'],
      sample: List<String>.from(json['sample']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mb_id': mbId,
      'nama': nama,
      'deskripsi': deskripsi,
      'harga_paket': hargaPaket,
      'sample': sample,
    };
  }
}
