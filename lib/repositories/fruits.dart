import 'package:akadomen/utils/constants/images.dart';

import '../models/juice.dart';

class FruitsRepositorie {
  static List<JuiceModel> juiceList = [
    JuiceModel(name: 'Apple', price: 80, image: ImageManager.apple),
    JuiceModel(name: 'Banana', price: 50, image: ImageManager.banana),
    JuiceModel(name: 'Cane', price: 50, image: ImageManager.cane),
    JuiceModel(
        name: 'Dragon fruit', price: 50, image: ImageManager.dragonFruit),
    JuiceModel(name: 'Kiwi', price: 50, image: ImageManager.kiwi),
    JuiceModel(name: 'Lemon', price: 50, image: ImageManager.lemon),
    JuiceModel(name: 'mango', price: 50, image: ImageManager.mango),
    JuiceModel(name: 'orange', price: 50, image: ImageManager.orange),
    JuiceModel(name: 'pineapple', price: 50, image: ImageManager.pineapple),
    JuiceModel(name: 'pomegranate', price: 50, image: ImageManager.pomegranate),
    JuiceModel(name: 'strawberry', price: 50, image: ImageManager.strawberry),
    JuiceModel(name: 'watermelon', price: 50, image: ImageManager.watermelon),
  ];
}
