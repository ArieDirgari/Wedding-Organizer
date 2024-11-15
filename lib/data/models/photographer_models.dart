
class Photographer {
  final int ptId;
  final String nama;
  final String deskripsi;
  final String telepon;
  final String email;
  final Map<String, String> mediaSosial;
  final List<HargaPaket> hargaPaket;
  final double rating;
  final List<String> sample;

  Photographer({
    required this.ptId,
    required this.nama,
    required this.deskripsi,
    required this.telepon,
    required this.email,
    required this.mediaSosial,
    required this.hargaPaket,
    required this.rating,
    required this.sample,
  });

  factory Photographer.fromJson(Map<String, dynamic> json) {
    
    return Photographer(
      ptId: json['pt_id'] ?? '',
      nama: json['nama'] ?? '',
      deskripsi: json['deskripsi'] ?? '',
      telepon: json['telepon'] ?? '',
      email: json['email'] ?? '',
      mediaSosial: Map<String, String>.from(json['media_sosial'] ?? {}),
      hargaPaket: (json['harga_paket'] as List).map((e) => HargaPaket.fromJson(e)).toList(),
      rating: (json['rating'] ?? 0).toDouble(),
      sample: List<String>.from(json['sample'] ?? []),
    );
  }
}


class SocialMedia {
  final String instagram;
  final String facebook;

  SocialMedia({
    required this.instagram,
    required this.facebook,
  });

  factory SocialMedia.fromJson(Map<String, dynamic> json) {
    return SocialMedia(
      instagram: json['instagram'],
      facebook: json['facebook'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'instagram': instagram,
      'facebook': facebook,
    };
  }
}

class HargaPaket {
  final String namaPaket;
  final String harga;

  HargaPaket({
    required this.namaPaket,
    required this.harga,
  });

  factory HargaPaket.fromJson(Map<String, dynamic> json) {
    return HargaPaket(
      namaPaket: json['nama_paket'],
      harga: json['harga'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama_paket': namaPaket,
      'harga': harga,
    };
  }
}
