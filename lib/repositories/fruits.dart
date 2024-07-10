import 'package:akadomen/utils/constants/images.dart';

import '../models/juice.dart';

class FruitsRepository {
  static List<JuiceModel> juiceList = [
    JuiceModel(name: 'Apple', price: 70, image: ImageManager.apple),
    JuiceModel(name: 'Banana', price: 50, image: ImageManager.banana),
    JuiceModel(name: 'Cane', price: 20, image: ImageManager.cane),
    JuiceModel(
        name: 'Dragon fruit', price: 100, image: ImageManager.dragonFruit),
    JuiceModel(name: 'Kiwi', price: 80, image: ImageManager.kiwi),
    JuiceModel(name: 'Lemon', price: 50, image: ImageManager.lemon),
    JuiceModel(name: 'mango', price: 55, image: ImageManager.mango),
    JuiceModel(name: 'orange', price: 60, image: ImageManager.orange),
    JuiceModel(name: 'pineapple', price: 75, image: ImageManager.pineapple),
    JuiceModel(name: 'pomegranate', price: 85, image: ImageManager.pomegranate),
    JuiceModel(name: 'strawberry', price: 55, image: ImageManager.strawberry),
    JuiceModel(name: 'watermelon', price: 70, image: ImageManager.watermelon),
  ];
}
