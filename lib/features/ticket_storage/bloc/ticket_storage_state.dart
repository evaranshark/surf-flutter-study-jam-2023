import 'package:surf_flutter_study_jam_2023/features/ticket_storage/data/ticket_model.dart';

class TicketStorageState {
  final List<TicketModel>? tickets;
  final bool isLoading;

  TicketStorageState({
    this.tickets,
    this.isLoading = false,
  });

  TicketStorageState copyWith({tickets, isLoading}) => TicketStorageState(
        tickets: tickets ?? this.tickets,
        isLoading: isLoading ?? this.isLoading,
      );
}
