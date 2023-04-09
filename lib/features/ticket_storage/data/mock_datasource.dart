import 'package:surf_flutter_study_jam_2023/features/ticket_storage/data/datasource.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/data/ticket_model.dart';

class MockDataSource implements DataSource {
  MockDataSource._();
  static MockDataSource? _instance;
  factory MockDataSource.instance() {
    _instance ??= MockDataSource._();
    return _instance!;
  }

  @override
  Future<void> addTicket(TicketModel ticket) {
    //TODO implement addTicket
    throw Exception();
  }

  @override
  Future<List<TicketModel>> getTickets() {
    var result = List.generate(
        8,
        (index) => TicketModel(
              name: 'Ticket $index',
              url:
                  'https://journal-free.ru/download/dachnye-sekrety-11-noiabr-2019.pdf',
              type: index.isEven ? TicketType.plane : TicketType.train,
            ));

    return Future.delayed(const Duration(seconds: 2), () => result);
  }
}
