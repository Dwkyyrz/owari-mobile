// class Product {
//   int? albumId;
//   int? id;
//   String? title;
//   var url;
//   String? thumbnailUrl;

//   Product({this.albumId, this.id, this.title, this.url, this.thumbnailUrl});

//   Product.fromJson(Map<String, dynamic> json) {
//     albumId = json['albumId'];
//     id = json['id'];
//     title = json['title'];
//     url = json['url'];
//     thumbnailUrl = json['thumbnailUrl'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['albumId'] = this.albumId;
//     data['id'] = this.id;
//     data['title'] = this.title;
//     data['url'] = this.url;
//     data['thumbnailUrl'] = this.thumbnailUrl;
//     return data;
//   }
// }

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
}

