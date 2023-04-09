import 'package:hive/hive.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/data/datasource.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/data/ticket_model.dart';

import '../config.dart';

class LocalDataSource implements DataSource {
  LocalDataSource._() {
    _box = TicketStorageConfig.ticketsBox;
  }
  static LocalDataSource? _instance;
  late final Box _box;
  Box get box => _box;
  factory LocalDataSource.instance() {
    _instance ??= LocalDataSource._();
    return _instance!;
  }
  @override
  Future<void> addTicket(TicketModel ticket) async {
    var ticketsBox = await Hive.openBox(box.name);
    ticketsBox.add(ticket.toHive());
  }

  @override
  Future<List<TicketModel>> getTickets() async {
    var ticketsBox = await Hive.openBox(box.name);
    var tickets = ticketsBox.values.map((e) => TicketModel.fromHive(e));

    return tickets.toList();
  }
}
