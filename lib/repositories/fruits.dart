import '../database/hive.dart';
import '../models/archive.dart';
import '../models/juice.dart';
import 'package:hive/hive.dart';

import '../utils/constants/images.dart';

class FruitsRepository {
  FruitsRepository._privateConstructor();
  static final FruitsRepository instance =
      FruitsRepository._privateConstructor();

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
    final juicesBox = Hive.box<Juice>('juices');
    List<Juice> userJuices =
        juicesBox.values.where((juice) => juice.username == username).toList();

    // Map Hive Juice objects to JuiceModel
    List<JuiceModel> userJuiceModels = userJuices
        .map((juice) => JuiceModel(
            name: juice.name, price: juice.price, image: juice.image))
        .toList();

    // Merging with predefined juice list
    List<JuiceModel> mergedList = [...juiceList, ...userJuiceModels];
    return mergedList;
  }

  Future<void> addUserJuice(String username, JuiceModel juice) async {
    final juicesBox = Hive.box<Juice>('juices');
    Juice newJuice = Juice()
      ..name = juice.name
      ..price = juice.price
      ..image = juice.image!
      ..username = username;
    await juicesBox.add(newJuice);
  }

  Future<void> removeUserJuice(String username, String juiceName) async {
    final juicesBox = Hive.box<Juice>('juices');
    final juice = juicesBox.values.firstWhere(
      (juice) => juice.username == username && juice.name == juiceName,
    );

    await juice.delete();
  }

  Future<void> updateJuicePrice(
      String username, String juiceName, int newPrice) async {
    final juicesBox = Hive.box<Juice>('juices');
    final juice = juicesBox.values.firstWhere(
      (juice) => juice.username == username && juice.name == juiceName,
    );

    juice.price = newPrice;
    await juice.save();
  }

  Future<List<ArchiveModel>?> getInvoices(String username) async {
    final invoicesBox = Hive.box<Invoice>('invoices');
    List<Invoice> userInvoices = invoicesBox.values
        .where((invoice) => invoice.username == username)
        .toList();

    return userInvoices
        .map((invoice) => ArchiveModel.fromMap({
              'invoice_number': invoice.invoiceNumber,
              'customer_name': invoice.customerName,
              'date': invoice.date,
              'time': invoice.time,
              'total_amount': invoice.totalAmount,
              'items': invoice.items,
              'username': invoice.username,
            }))
        .toList();
  }

  Future<void> saveInvoice({
    required int invoiceNumber,
    required String customerName,
    required String formattedDate,
    required String formattedTime,
    required double totalAmount,
    required String items,
    required String userName,
  }) async {
    final invoicesBox = Hive.box<Invoice>('invoices');
    Invoice newInvoice = Invoice()
      ..invoiceNumber = invoiceNumber
      ..customerName = customerName
      ..date = formattedDate
      ..time = formattedTime
      ..totalAmount = totalAmount
      ..items = items
      ..username = userName;
    await invoicesBox.add(newInvoice);
  }
}
