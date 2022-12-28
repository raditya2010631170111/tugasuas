// Kelompok 1 - Raditya Aji S - Raihan Akbar Saputro - Sopiatul Ulum - Reza Zulfiqri - Nazwa Ariana S - aplikasi (Consume API dan Sqflite) plagiasi 50%

class Onlineshop {
  late int? idHp;
  late String? merek;
  late String? spesifikasi;
  late String? harga;
  //late String? gambar;

  OnlineShop(
      {this.idHp,
      required this.merek,
      required this.spesifikasi,
      required this.harga}); 

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (idHp != null) {
      map['ID HP'] = idHp;
    }
    map['Merek'] = merek; //<'id' = String = "key", id = dynamic = "value">
    map['Spesifikasi'] = spesifikasi;
    map['Harga'] = harga;
    //map['Gambar'] = gambar,
    return map;
  }

  OnlineShop.fromMap(Map<String, dynamic> map) {
    //constructor
    this.idHp = map['ID HP'];
    this.merek = map['Merek'];
    this.spesifikasi = map['Spesifikasi'];
    this.harga = map['Harga'];
    //this.gambar = map['Gambar'];
  }
}
