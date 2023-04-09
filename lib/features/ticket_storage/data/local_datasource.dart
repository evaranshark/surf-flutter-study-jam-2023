import 'package:hive/hive.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/data/datasource.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/data/ticket_model.dart';

import '../config.dart';

class LocalDataSource implements DataSource {
  LocalDataSource._() {}
  static LocalDataSource? _instance;
  late Box ticketsBox;
  factory LocalDataSource.instance() {
    _instance ??= LocalDataSource._();
    return _instance!;
  }
  @override
  Future<void> addTicket(TicketModel ticket) async {
    var ticketsBox = await Hive.openBox<TicketModel>('tickets');
    await ticketsBox.add(ticket);
    ticketsBox.close();
  }

  @override
  Future<List<TicketModel>> getTickets() async {
    var ticketsBox = await Hive.openBox<TicketModel>('tickets');
    var tickets = ticketsBox.values.toList();
    ticketsBox.close();
    return tickets.toList();
  }
}
