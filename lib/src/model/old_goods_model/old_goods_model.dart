class OldGoodsModel {
  String? image;
  String? address;
  String? price;
  String? name;
  String? contactNumber;
  String? postDate;

  OldGoodsModel(
      {this.image,
        this.address,
        this.price,
        this.name,
        this.contactNumber,
        this.postDate});

  OldGoodsModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    address = json['address'];
    price = json['price'];
    name = json['name'];
    contactNumber = json['contactNumber'];
    postDate = json['postDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['address'] = this.address;
    data['price'] = this.price;
    data['name'] = this.name;
    data['contactNumber'] = this.contactNumber;
    data['postDate'] = this.postDate;
    return data;
  }
}
