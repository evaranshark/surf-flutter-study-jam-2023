import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/data/ticket_model.dart';

import 'bloc/ticket_storage_bloc.dart';
import 'data/local_datasource.dart';

class TicketStorageConfig {
  static late final TicketStorageCubit? _ticketStorageCubit;
  static TicketStorageCubit get storageCubit => _ticketStorageCubit!;
  static late final Box _box;
  static Box get ticketsBox => _box;
  Future<void> init() async {
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    _box = await Hive.openBox('tickets');
    _ticketStorageCubit =
        TicketStorageCubit(source: LocalDataSource.instance());
  }
}
