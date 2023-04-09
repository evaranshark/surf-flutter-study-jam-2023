import 'package:surf_flutter_study_jam_2023/features/ticket_storage/data/ticket_model.dart';

abstract class DataSource {
  Future<List<TicketModel>> getTickets();
  Future<void> addTicket(TicketModel ticket);
}
