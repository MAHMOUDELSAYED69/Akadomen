import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../database/hive.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  final _hiveDb = HiveDb();
  Future<void> register(String username, String password) async {
    try {
      final result = await _hiveDb.insertUser(username, password);

      if (result == 0) {
        emit(UsernameTaken()); // User already exists
      } else {
        emit(RegisterSuccess()); // User successfully registered
        log("Registered user: $username");
      }
    } catch (e) {
      log("Failed to register user: $username. Error: $e");
      emit(RegisterFailure());
    }
  }
}
