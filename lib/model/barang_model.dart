class BarangModel {
  int? id; 
  String kodeBarang;
  String nomorBarang;
  String namaBarang;
  double hargaBarang;
  int jumlahBarang;
  double total;

  BarangModel({
    this.id,
    required this.kodeBarang,
    required this.nomorBarang,
    required this.namaBarang,
    required this.hargaBarang,
    required this.jumlahBarang,
    required this.total,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'kode_barang': kodeBarang,
      'nomor_barang': nomorBarang,
      'nama_barang': namaBarang,
      'harga_barang': hargaBarang,
      'jumlah_barang': jumlahBarang,
      'total': total,
    };
  }

  factory BarangModel.fromMap(Map<String, dynamic> map) {
    return BarangModel(
      id: map['id'],
      kodeBarang: map['kode_barang'],
      nomorBarang: map['nomor_barang'],
      namaBarang: map['nama_barang'],
      hargaBarang: map['harga_barang'],
      jumlahBarang: map['jumlah_barang'],
      total: map['total'],
    );
  }
}
