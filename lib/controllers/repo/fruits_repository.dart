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

  Future<void> addUserJuice(String name, int price, String image) async {
    final username = await _getUsername();
    final newJuice = JuiceModel(name: name, price: price, image: image);
    await FruitsRepository.instance.addUserJuice(username, newJuice);
    loadUserJuices();
  }

  Future<void> removeUserJuice(String juiceName) async {
    final username = await _getUsername();
    await FruitsRepository.instance.removeUserJuice(username, juiceName);
    loadUserJuices();
  }

  Future<String> _getUsername() async {
    return CacheData.getData(key: 'currentUser');
  }
}
