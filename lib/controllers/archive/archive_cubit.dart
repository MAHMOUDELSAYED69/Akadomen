import 'package:akadomen/repositories/fruits.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/archive.dart';
import '../../utils/helpers/shared_pref.dart';

part 'archive_state.dart';

class ArchiveCubit extends Cubit<ArchiveState> {
  ArchiveCubit() : super(ArchiveInitial());

  Future<void> fetchInvoices() async {
    emit(ArchiveLoading());
    final List<ArchiveModel>? invoices = await FruitsRepository.instance
        .getInvoices(CacheData.getData(key: 'currentUser'));
    emit(ArchiveLoaded(list: invoices ?? []));
  }
}
