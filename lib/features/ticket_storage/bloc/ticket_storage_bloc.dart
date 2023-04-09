import 'package:surf_flutter_study_jam_2023/core/pdf_name_resolver.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/bloc/ticket_storage_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/data/datasource.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/data/ticket_model.dart';

class TicketStorageCubit extends Cubit<TicketStorageState> {
  final DataSource source;
  TicketStorageCubit({required this.source}) : super(TicketStorageState()) {
    load();
  }

  void load() async {
    emit(state.copyWith(isLoading: true));
    var data = await source.getTickets();
    emit(state.copyWith(isLoading: false, tickets: data));
  }

  void addTicket(String url) async {
    TicketModel ticket = TicketModel(
      name: PdfNameResolver.getName(url),
      url: url,
    );
    source.addTicket(ticket);
    load();
  }
}
