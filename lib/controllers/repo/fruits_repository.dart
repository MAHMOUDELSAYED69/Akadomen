import 'package:akadomen/utils/helpers/shared_pref.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/juice.dart';
import '../../repositories/fruits.dart';

class FruitsRepositoryCubit extends Cubit<List<JuiceModel>> {
  FruitsRepositoryCubit() : super([]) {
    loadUserJuices();
  }

  Future<void> loadUserJuices() async {
    final username = await _getUsername();
    final juices = await FruitsRepository.instance.getUserJuices(username);
    emit(juices);
  }

  Future<void> addUserJuice(
      {required String name, required int price, required String image}) async {
    final username = await _getUsername();
    final newJuice = JuiceModel(name: name, price: price, image: image);
    await FruitsRepository.instance.addUserJuice(username, newJuice);
    await loadUserJuices();
  }

  Future<void> removeUserJuice({required String juiceName}) async {
    final username = await _getUsername();
    await FruitsRepository.instance.removeUserJuice(username, juiceName);
    await loadUserJuices();
  }

  Future<void> updateJuicePrice(
      {required JuiceModel juice, required int newPrice}) async {
    final username = await _getUsername();
    await FruitsRepository.instance
        .updateJuicePrice(username, juice.name, newPrice);
    await loadUserJuices();
  }

  Future<String> _getUsername() async {
    return CacheData.getData(key: 'currentUser');
  }
}
