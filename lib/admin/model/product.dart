class Product {
  int? pId;
  int? catId;
  String? nama;
  String? deskripsi;
  int? stock;
  String? harga;
  String? ukuran;
  String? foto;

  Product(
      {this.pId,
      this.catId,
      this.nama,
      this.deskripsi,
      this.stock,
      this.harga,
      this.ukuran,
      this.foto});

  Product.fromJson(Map<String, dynamic> json) {
    pId = json['p_id'];
    catId = json['cat_id'];
    nama = json['nama'];
    deskripsi = json['deskripsi'];
    stock = json['stock'];
    harga = json['harga'];
    ukuran = json['ukuran'];
    foto = json['foto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['p_id'] = this.pId;
    data['cat_id'] = this.catId;
    data['nama'] = this.nama;
    data['deskripsi'] = this.deskripsi;
    data['stock'] = this.stock;
    data['harga'] = this.harga;
    data['ukuran'] = this.ukuran;
    data['foto'] = this.foto;
    return data;
  }

  Map<String, dynamic> toJsonAdd() {
    return {
      "Nama": nama,
      "Deskripsi": deskripsi,
      "Stock": stock,
      "Harga": harga,
      "Ukuran": ukuran,
      "Foto": foto,
    };
  }
}
