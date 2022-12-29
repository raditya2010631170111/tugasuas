// Kelompok 1 - Raditya Aji S - Raihan Akbar Saputro - Sopiatul Ulum - Reza Zulfiqri - Nazwa Ariana S - aplikasi (Consume API dan Sqflite) plagiasi 50%
//shared_preference & sqflite

class Onlineshop {
  late int? idHp;
  late String merek;
  late String spesifikasi;
  late String harga;
  //late String? gambar;

  Onlineshop(
      {this.idHp,
      required this.merek,
      required this.spesifikasi,
      required this.harga});

  Map<String, dynamic> toMap() {
    return {
      'ID HP': idHp,
      'Merek': merek,
      'Spesifikasi': spesifikasi,
      'Harga': harga,
    };
  }

  Onlineshop.fromMap(Map<String, dynamic> map) {
    //constructor
    idHp = map['ID HP'];
    merek = map['Merek'];
    spesifikasi = map['Spesifikasi'];
    harga = map['Harga'];
    //this.gambar = map['Gambar'];
  }
}
