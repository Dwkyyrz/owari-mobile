class Model {
  String? nama;
  String? harga;
  String? category;
  String? ukuran;

  Model({this.nama, this.harga, this.category, this.ukuran});

  Model.fromJson(Map<String, dynamic> json) {
    nama = json['nama'];
    harga = json['harga'];
    category = json['category'];
    ukuran = json['ukuran'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nama'] = this.nama;
    data['harga'] = this.harga;
    data['category'] = this.category;
    data['ukuran'] = this.ukuran;
    return data;
  }
}
