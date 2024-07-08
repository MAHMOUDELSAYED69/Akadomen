class JuiceModel {
  final int? id;
  final String name;
  final int price;
  final String image;

  JuiceModel({
    this.id,
    required this.name,
    required this.price,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'name': name,
      'price': price,
      'image': image,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  factory JuiceModel.fromMap(Map<String, dynamic> map) {
    return JuiceModel(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      image: map['image'],
    );
  }

  @override
  String toString() {
    return 'Juice{id: $id, name: $name, price: $price, image: $image}';
  }
}
