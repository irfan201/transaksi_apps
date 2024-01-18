class TransactionModel {
  int? id;
  String nomor;
  String date;
  String kode;
  String nama;
  String nomorTelepon;
  String namaBarang;
  double hargaBarang;
  int jumlahBarang;
  double total;


  TransactionModel({
    this.id,
    required this.nomor,
    required this.date,
    required this.kode,
    required this.nama,
    required this.nomorTelepon,
    required this.namaBarang,
    required this.hargaBarang,
    required this.jumlahBarang,
    required this.total,
  });


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nomor': nomor,
      'date': date,
      'kode': kode,
      'nama': nama,
      'nomor_telepon': nomorTelepon,
      'nama_barang': namaBarang,
      'harga_barang': hargaBarang,
      'jumlah_barang': jumlahBarang,
      'total': total,
    };
  }
}
