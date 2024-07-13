import '../database/sql.dart';
import '../models/juice.dart';
import '../utils/constants/images.dart';

class FruitsRepository {
  FruitsRepository._privateConstructor();
  static final FruitsRepository instance =
      FruitsRepository._privateConstructor();

  final SqlDb _sqlDb = SqlDb();

  static List<JuiceModel> juiceList = [
    JuiceModel(name: 'Apple', price: 70, image: ImageManager.apple),
    JuiceModel(name: 'Banana', price: 50, image: ImageManager.banana),
    JuiceModel(name: 'Cane', price: 20, image: ImageManager.cane),
    JuiceModel(
        name: 'Dragon fruit', price: 100, image: ImageManager.dragonFruit),
    JuiceModel(name: 'Kiwi', price: 80, image: ImageManager.kiwi),
    JuiceModel(name: 'Lemon', price: 50, image: ImageManager.lemon),
    JuiceModel(name: 'Mango', price: 55, image: ImageManager.mango),
    JuiceModel(name: 'Orange', price: 60, image: ImageManager.orange),
    JuiceModel(name: 'Pineapple', price: 75, image: ImageManager.pineapple),
    JuiceModel(name: 'Pomegranate', price: 85, image: ImageManager.pomegranate),
    JuiceModel(name: 'Strawberry', price: 55, image: ImageManager.strawberry),
    JuiceModel(name: 'Watermelon', price: 70, image: ImageManager.watermelon),
  ];

  Future<List<JuiceModel>> getUserJuices(String username) async {
    final data = await _sqlDb.readData(
        data: 'SELECT * FROM juices WHERE username = "$username"');
    List<JuiceModel> userJuices = data
            ?.map((item) => JuiceModel(
                  name: item['name'] as String,
                  price: item['price'] as int,
                  image: item['image'] as String,
                ))
            .toList() ??
        [];

    List<JuiceModel> mergedList = [...juiceList];
    mergedList.addAll(userJuices);

    return mergedList;
  }

  Future<void> addUserJuice(String username, JuiceModel juice) async {
    final data = '''
      INSERT INTO juices (name, price, image, username)
      VALUES ('${juice.name}', ${juice.price}, '${juice.image}', "$username")
    ''';
    await _sqlDb.insertData(data: data);
  }

  Future<void> removeUserJuice(String username, String juiceName) async {
    final data = '''
      DELETE FROM juices WHERE username = "$username" AND name = '$juiceName'
    ''';
    await _sqlDb.deleteData(data: data);
  }
}
